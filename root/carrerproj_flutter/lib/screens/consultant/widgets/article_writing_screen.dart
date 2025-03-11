import 'package:carrerproj_client/authinticationproj_client.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
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
  int? _authorId;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  // Load authenticated user ID
  Future<void> _loadUser() async {
    var user = await sessionManager.signedInUser!;
    if (user != null) {
      setState(() {
        _authorId = user.id;
      });
    }
  }

  // Save article as a draft
  Future<void> _onSaveDraft() async {
    if (_authorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: User not authenticated')),
      );
      return;
    }

    String title = _titleController.text;
    String content = _articleController.text;

    var article = Article(
      title: title,
      content: content,
      authorId: _authorId!,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      shares: 0,
      isArchived: true, // Mark as draft
    );

    try {
      await client.article.insertArticle(article);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Draft saved: $title')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving draft: $e')),
      );
    }
  }

  // Publish article
  Future<void> _onPublish() async {
    if (_authorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: User not authenticated')),
      );
      return;
    }

    String title = _titleController.text;
    String content = _articleController.text;

    print("📝 Attempting to save draft: Title = $title, Content Length = ${content.length}");

    var article = Article(
      title: title,
      content: content,
      authorId: _authorId!,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      shares: 0,
      isArchived: false, // Mark as published
    );

    try {
      await client.article.insertArticle(article);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Article published: $title')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error publishing article: $e')),
      );
    }
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
              AIAssistantWidget(), // ✅ Keeping AI Assistant Widget
              SizedBox(height: 10),
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
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Write your article here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _titleController.clear();
                        _articleController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Article discarded')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DashboardPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: (){
                         _onSaveDraft;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Save Draft'),
                    ),
                    ElevatedButton(
                      onPressed: (){
                          _onPublish;
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DashboardPage()),
                        );
                      } , 
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
