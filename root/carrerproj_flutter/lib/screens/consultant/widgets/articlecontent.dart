import 'package:carrerproj_client/authinticationproj_client.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';

class ArticleContent extends StatefulWidget {
  @override
  _ArticleContentState createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  late Future<List<Article>> _articlesFuture;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _articlesFuture = _fetchArticles();
  }

  Future<List<Article>> _fetchArticles({String query = ""}) async {
    final articles = await client.article.getRecentArticles();
    if (query.isNotEmpty) {
      return articles.where((article) => article.title.toLowerCase().contains(query.toLowerCase())).toList();
    }
    return articles;
  }

  void _showCreateArticleDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Article"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Title")),
            TextField(controller: contentController, maxLines: 5, decoration: InputDecoration(labelText: "Content")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              Article newArticle = Article(
                title: titleController.text,
                content: contentController.text,
                authorId: sessionManager.signedInUser!.id ?? 0,
                createdAt: DateTime.now(),
                shares: 0,
                isArchived: false,
              );
              await client.article.insertArticle(newArticle);
              setState(() {
                _articlesFuture = _fetchArticles();
              });
              Navigator.pop(context);
            },
            child: Text("Save as Draft"),
          ),
        ],
      ),
    );
  }

  void _showPreviewDialog(BuildContext context, Article article) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(article.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Content: ${article.content}"),
            Text("Likes: 0, Shares: ${article.shares}, Comments: 0"),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Close")),
        ],
      ),
    );
  }

  void _deleteArticle(Article article) async {
    await client.article.deleteArticle(article);
    setState(() {
      _articlesFuture = _fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search Articles...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (query) {
                    setState(() {
                      _articlesFuture = _fetchArticles(query: query);
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _showCreateArticleDialog(context),
                child: Text("Create New Article"),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Article>>(
            future: _articlesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("No articles found."));
              }
              
              final articles = snapshot.data!;
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return ListTile(
                    title: Text(article.title),
                    subtitle: Text("Created At: ${article.createdAt}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () => _showPreviewDialog(context, article),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteArticle(article),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
