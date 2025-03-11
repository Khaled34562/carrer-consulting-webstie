import 'package:flutter/material.dart';

class AIAssistantWidget extends StatefulWidget {
  @override
  _AIAssistantWidgetState createState() => _AIAssistantWidgetState();
}

class _AIAssistantWidgetState extends State<AIAssistantWidget> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, String>> _messages = []; // Stores questions and responses

  void _submitQuestion() {
    String question = _questionController.text;
    if (question.isNotEmpty) {
      // Add the user's question to the messages list
      setState(() {
        _messages.add({'type': 'user', 'text': question});
      });

      // Simulate an AI response (replace this with actual AI API call)
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _messages.add({'type': 'ai', 'text': 'This is a response from the AI.'});
        });
      });

      _questionController.clear(); // Clear the input field
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a question')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7, // 90% of screen width
      height: MediaQuery.of(context).size.height * 0.3, // 70% of screen height
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // AI Icon at the top left corner
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.assistant, color: Colors.blue, size: 32),
                SizedBox(width: 8),
                Text(
                  'AI Assistant',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          // Chat Area (Questions and Responses)
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['type'] == 'user';
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          // Input Area (Text Field and Submit Button)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _questionController,
                      decoration: InputDecoration(
                        hintText: 'Ask me anything...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}