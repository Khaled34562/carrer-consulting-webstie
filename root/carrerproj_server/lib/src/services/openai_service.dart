import 'package:dart_openai/dart_openai.dart';

// ================== ENUMS ==================
enum OpenAIChatMessageContentType {
  text,
  imageUrl,
}


// ================== CONTENT ITEM MODEL ==================
class OpenAIChatMessageContentItemModel {
  final OpenAIChatMessageContentType type;
  final String? text;
  final String? imageUrl;

  OpenAIChatMessageContentItemModel.text(this.text)
      : type = OpenAIChatMessageContentType.text,
        imageUrl = null;

  OpenAIChatMessageContentItemModel.imageUrl(this.imageUrl)
      : type = OpenAIChatMessageContentType.imageUrl,
        text = null;

  Map<String, dynamic> toJson() {
    switch (type) {
      case OpenAIChatMessageContentType.text:
        return {'type': 'text', 'text': text};
      case OpenAIChatMessageContentType.imageUrl:
        return {
          'type': 'image_url',
          'image_url': {'url': imageUrl}
        };
    }
  }
}

// ================== MESSAGE MODEL ==================
class OpenAIChatCompletionMessageModel {
  final OpenAIChatMessageRole role;
  final List<OpenAIChatMessageContentItemModel> content;

  OpenAIChatCompletionMessageModel({
    required this.role,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role.name,
      'content': content.map((item) => item.toJson()).toList(),
    };
  }
}

// ================== OPENAI SERVICE ==================
class OpenAIService {
  final String apiKey;

  OpenAIService(this.apiKey) {
    OpenAI.apiKey = apiKey;
  }

  Future<Object?> generateResponse(String prompt) async {
    try {
      final chatCompletion = await OpenAI.instance.chat.create(
        model: "gpt-4",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)],
          ),
        ],
      );

      return _handleResponseContent(chatCompletion);
    } catch (e) {
      print("OpenAI Error: $e");
      return "Error: ${e.toString()}";
    }
  }

  Object? _handleResponseContent(OpenAIChatCompletionModel chatCompletion) {
    if (chatCompletion.choices.isEmpty) return "No response from AI.";

    final message = chatCompletion.choices.first.message;

    final content = message.content;

    if (content is String) {
      return content;
    } else if (content is List) {
      return content
          ?.whereType<Map<String, dynamic>>()
          .map((item) => _parseContentItem(item))
          .join(' ');
    }

    return "Unsupported response format.";
  }

  String _parseContentItem(Map<String, dynamic> item) {
    if (item['type'] == 'text') {
      return item['text'] ?? '';
    }
    return '';
  }
}
