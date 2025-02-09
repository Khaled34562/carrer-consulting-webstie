import 'package:serverpod/serverpod.dart';
import '../services/openai_service.dart';

class OpenAIEndpoint extends Endpoint {
  late final OpenAIService _openAIService;

  // Constructor to receive API key from server.dart
  OpenAIEndpoint({required String apiKey}) {
    _openAIService = OpenAIService(apiKey);
  }

  /// API endpoint to get AI-generated response
  Future<Object?> getAIResponse(Session session, String userMessage) async {
    return await _openAIService.generateResponse(userMessage);
  }
}