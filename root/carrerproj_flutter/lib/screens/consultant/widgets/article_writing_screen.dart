import 'package:flutter/material.dart';
import 'ai_assistant_widget.dart';
import 'package:carrerproj_flutter/screens/consultant/homepage.dart';

class ArticleWritingScreen extends StatefulWidget {
  @override
  _ArticleWritingScreenState createState() => _ArticleWritingScreenState();
}

class _ArticleWritingScreenState extends State<ArticleWritingScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _articleController = TextEditingController();
  

  void _onCancel() {
    _titleController.clear();
    _articleController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Article discarded')),
    );
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  }

  void _onSaveDraft() {
    String title = _titleController.text;
    String draft = _articleController.text;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Draft saved: $title')),
    );
  }

  void _onPublish() {
    String title = _titleController.text;
    String article = _articleController.text;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Article published: $title')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write an Article'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              AIAssistantWidget(),
              SizedBox(height: 10),

              // 📝 Title Input Field
              Container(
                width: 1000,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter article title...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // ✍️ Article Content Field
              Container(
                width: 1000,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: TextField(
                  controller: _articleController,
                  maxLines: null, // Allows unlimited lines
                  decoration: InputDecoration(
                    hintText: 'Write your article here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // 🔘 Buttons Row
              SizedBox(
                width: 800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _onSaveDraft,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Save Draft'),
                    ),
                    ElevatedButton(
                      onPressed: _onPublish,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Publish'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
