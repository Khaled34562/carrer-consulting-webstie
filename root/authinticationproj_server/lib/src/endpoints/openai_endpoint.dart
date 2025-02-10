import 'package:authinticationproj_server/src/services/openai_service.dart';
import 'package:serverpod/serverpod.dart';

class OpenAIEndpoint extends Endpoint {
  final OpenAIService _openAIService;

  OpenAIEndpoint({required String apiKey})
      : _openAIService = OpenAIService(apiKey);

  Future<Object?> getAIResponse(Session session, String userMessage) async {
    
    return await _openAIService.generateResponse(userMessage).toString();
  }
}
