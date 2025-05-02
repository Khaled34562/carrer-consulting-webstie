import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../generated/protocol.dart';

class CVReviewEndpoint extends Endpoint {
  /// Reviews a user's CV by sending it to OpenAI for feedback
  /// Returns a CVReview object containing the feedback
  Future<CVReview> reviewCV(Session session, String cvText, int userId) async {
    // Verify user exists and get profile
    final user = await _verifyUserExists(session, userId);

    // Create review record
    var review = CVReview(
      userId: userId,
      originalCV: cvText,
      createdAt: DateTime.now().toUtc(),
      targetLanguage: user.languages?.firstOrNull,
      targetCountry: user.country,
      cvId: 0,
    );

    // Insert initial record
    review = await CVReview.db.insertRow(session, review);

    try {
      // Get feedback from OpenAI
      final feedback = await _getCVFeedback(
        cvText,
        user.languages?.firstOrNull ?? 'English',
        user.country,
      );

      // Update with feedback
      review.feedback = feedback;
      review.reviewedAt = DateTime.now().toUtc();
      review.status = "completed";

      return await CVReview.db.updateRow(session, review);
    } catch (e, stackTrace) {
      session.log(
        'CV review failed',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );

      review.status = 'failed';
      review.error = e.toString();
      return await CVReview.db.updateRow(session, review);
    }
  }

  /// Gets all CV reviews for a user
  Future<List<CVReview>> getUserReviews(
    Session session,
    int userId, {
    int limit = 10,
    int offset = 0,
  }) async {
    return await CVReview.db.find(
      session,
      where: (r) => r.userId.equals(userId),
      orderBy: (r) => r.createdAt,
      limit: limit,
      offset: offset,
    );
  }

  /// Gets a specific review by ID
  Future<CVReview?> getReview(Session session, int reviewId) async {
    return await CVReview.db.findById(session, reviewId);
  }

  /// Deletes a CV review
  Future<void> deleteReview(Session session, int reviewId) async {
    await CVReview.db.deleteWhere(
      session,
      where: (r) => r.id.equals(reviewId),
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

  Future<String> _getCVFeedback(
    String cvText,
    String? language,
    String? country,
  ) async {
    const apiKey = 'Your-key'; // Use config or secrets manager
    final locale = language ?? 'English';
    final countryInfo = country != null ? ' for $country job market' : '';

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
You are a professional career advisor. Provide detailed CV feedback in $locale$countryInfo.
Focus on:
1. Structure and formatting
2. Content relevance
3. Grammar and clarity
4. Impact and achievements
5. Local market suitability
'''
          },
          {'role': 'user', 'content': 'Please review this CV:\n\n$cvText'}
        ],
        'temperature': 0.7,
        'max_tokens': 1500,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('OpenAI API error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'];
  }
}