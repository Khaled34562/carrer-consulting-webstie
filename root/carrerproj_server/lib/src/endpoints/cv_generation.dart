import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../generated/protocol.dart';

class CVGenerationEndpoint extends Endpoint {
  /// Generates a CV based on user's profile data
  Future<CVGeneration> generateCV(Session session, int userId) async {
    // Get user profile
    final user = await _verifyUserExists(session, userId);

    // Create generation record
    var generation = CVGeneration(
      userId: userId,
      createdAt: DateTime.now().toUtc(),
      userProfileSnapshot: user,
      status: 'processing', cvId: 0, // Replace with a default int value
    );

    // Insert initial record
    generation = await CVGeneration.db.insertRow(session, generation);

    try {
      // Generate CV content
      final cvContent = await _generateCVContent(user);

      // Update with results
      generation.generatedCV = cvContent;
      generation.generatedAt = DateTime.now().toUtc();
      generation.status = 'completed';

      return await CVGeneration.db.updateRow(session, generation);
    } catch (e, stackTrace) {
      session.log(
        'CV generation failed',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );

      generation.status = 'failed';
      generation.error = e.toString();
      return await CVGeneration.db.updateRow(session, generation);
    }
  }

  /// Gets all CV generations for a user
  Future<List<CVGeneration>> getUserGenerations(
    Session session,
    int userId, {
    int limit = 10,
    int offset = 0,
  }) async {
    return await CVGeneration.db.find(
      session,
      where: (g) => g.userId.equals(userId),
      orderBy: (g) => g.createdAt,
      limit: limit,
      offset: offset,
    );
  }

  /// Gets a specific generation by ID
  Future<CVGeneration?> getGeneration(Session session, int generationId) async {
    return await CVGeneration.db.findById(session, generationId);
  }

  /// Deletes a CV generation
  Future<void> deleteGeneration(Session session, int generationId) async {
    await CVGeneration.db.deleteWhere(
      session,
      where: (g) => g.id.equals(generationId),
    );
  }

  // --- Helper Methods ---

  Future<UserProfile> _verifyUserExists(Session session, int userId) async {
    final user = await UserProfile.db.findById(session, userId);
    if (user == null) {
      throw Exception('User not found');
    }
    return user;
  }

  Future<String> _generateCVContent(UserProfile user) async {
    const apiKey = 'Your-key'; // Use config or secrets manager
    final language = user.languages?.firstOrNull ?? 'English';

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': [
          {
            'role': 'system',
            'content': '''
You are a professional CV writer. Create a well-structured CV in $language.
Follow these guidelines:
1. Use standard CV format for ${user.country ?? 'international'} market
2. Highlight skills and experience relevant to ${user.educationLevel ?? 'the candidate'}
3. Include all standard sections
4. Make it professional and achievement-oriented
'''
          },
          {
            'role': 'user',
            'content': '''
Generate a CV for:
- Name: ${user.fullName}
- Contact: [REDACTED - use placeholder]
- DOB: ${user.dateOfBirth?.toIso8601String() ?? 'N/A'}
- Country: ${user.country ?? 'N/A'}
- Languages: ${user.languages?.join(', ') ?? 'N/A'}
- Education Level: ${user.educationLevel ?? 'N/A'}
- Hourly Rate: \$${user.hourlyRate?.toStringAsFixed(2) ?? 'N/A'}

Create realistic work experience based on education level.
'''
          }
        ],
        'temperature': 0.5,
        'max_tokens': 2000,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('OpenAI API error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'];
  }
}