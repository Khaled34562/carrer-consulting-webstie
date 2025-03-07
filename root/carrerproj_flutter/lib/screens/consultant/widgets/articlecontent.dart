import 'package:carrerproj_client/authinticationproj_client.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'article_writing_screen.dart';


class ArticleContent extends StatefulWidget {
  @override
  _ArticleContentState createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  late Future<List<Article>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = _fetchArticles();
  }

  Future<List<Article>> _fetchArticles() async {
    return await client.article.fetchRecentArticles(); // Fetch articles from Serverpod
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔍 Search and Create Article
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search Articles...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle Create New Article
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ArticleWritingScreen()),
                   );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Create New Article"),
              ),
            ],
          ),
        ),

        /// 📋 Article Table
        Expanded(
          child: FutureBuilder<List<Article>>(
            future: _articlesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No articles found."));
              }

              final articles = snapshot.data!;
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return _buildArticleRow(
                    context,
                    article.title,
                    article.createdAt.toLocal().toString(),
                    "Uncategorized",
                    article.content,
                    "Draft",
                    0,
                    article.likes ?? 0,
                    0,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  /// 📝 Article Row Widget
  Widget _buildArticleRow(
    BuildContext context,
    String title,
    String date,
    String category,
    String content,
    String status,
    int views,
    int likes,
    int comments,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 📌 Article Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("📅 Date: $date"),
                    Text("🏷️ Category: $category"),
                    Text("📌 Status: $status"),
                  ],
                ),

                /// 📊 Stats & Actions
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.remove_red_eye, color: Colors.blueAccent),
                        const SizedBox(width: 5),
                        Text("$views"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.thumb_up, color: Colors.green),
                        const SizedBox(width: 5),
                        Text("$likes"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.comment, color: Colors.orange),
                        const SizedBox(width: 5),
                        Text("$comments"),
                      ],
                    ),
                  ],
                ),

                /// 🛠️ Actions
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {
                        _showPreviewDialog(context, title, content);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit article
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.blue),
                      onPressed: () {
                        _shareArticle(title, content);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.archive),
                      onPressed: () {
                        // Handle archive article
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteConfirmation(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ❌ Delete Confirmation
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Article"),
        content: const Text("Are you sure you want to delete this article?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Handle delete logic
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// 👀 Preview Article
  void _showPreviewDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 400,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(content),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 📢 Share Article (Dummy function)
  void _shareArticle(String title, String content) {
    // You can integrate with the Share package to share content
    print("Sharing article: $title");
  }
}