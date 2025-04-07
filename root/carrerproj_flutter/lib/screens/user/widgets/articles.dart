import 'dart:convert';
import 'package:carrerproj_client/carrerproj_client.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';

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

  void _refreshArticles() {
    setState(() {
      _articlesFuture = _fetchArticles(query: _searchController.text);
    });
  }

  Future<String> _getAuthorName(int authorId) async {
    final userProfile = await client.user.getUserProfile(authorId);
    return userProfile?.fullName ?? 'Unknown';
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (query) {
                    _refreshArticles();
                  },
                ),
              ),
              SizedBox(width: 10),
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
                padding: EdgeInsets.all(10),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return _buildArticleCard(context, article);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildArticleCard(BuildContext context, Article article) {
    final currentUserId = sessionManager.signedInUser!.id!;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            FutureBuilder<String>(
              future: _getAuthorName(article.authorId),
              builder: (context, snapshot) {
                final authorName = snapshot.data ?? 'Unknown';
                final isCurrentUserAuthor = article.authorId == currentUserId;
                return Text(
                  "By: $authorName${isCurrentUserAuthor ? ' (You)' : ''}",
                  style: TextStyle(color: Colors.grey),
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, size: 16),
                    SizedBox(width: 4),
                    FutureBuilder<int>(
                      future: client.articleLike.getLikeCount(article.id!),
                      builder: (_, snap) => Text(snap.data?.toString() ?? "0"),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.share, size: 16),
                    SizedBox(width: 4),
                    Text("${article.shares}"),
                    SizedBox(width: 10),
                    Icon(Icons.comment, size: 16),
                    SizedBox(width: 4),
                    FutureBuilder<List<Comment>>(
                      future: client.comment.getCommentsByArticle(article.id!),
                      builder: (_, snap) => Text(snap.data?.length.toString() ?? "0"),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArticlePreviewPage(
                          article: article,
                          onArticleUpdated: _refreshArticles,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class ArticlePreviewPage extends StatefulWidget {
  final Article article;
  final VoidCallback onArticleUpdated;

  ArticlePreviewPage({required this.article, required this.onArticleUpdated});

  @override
  _ArticlePreviewPageState createState() => _ArticlePreviewPageState();
}

class _ArticlePreviewPageState extends State<ArticlePreviewPage> {
  late QuillController _quillController;
  TextEditingController _commentController = TextEditingController();
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _quillController = QuillController(
      document: Document.fromJson(jsonDecode(widget.article.content)),
      selection: TextSelection.collapsed(offset: 0),
    );
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    final userId = sessionManager.signedInUser!.id!;
    final likedArticles = await client.articleLike.getLikedArticlesByUser(userId);
    setState(() {
      _isLiked = likedArticles.any((like) => like.articleId == widget.article.id);
    });
  }

  Future<String> _getUserName(int userId) async {
    final userProfile = await client.user.getUserProfile(userId);
    return userProfile?.fullName ?? 'Unknown';
  }

  Future<void> _toggleLike() async {
    final userId = sessionManager.signedInUser!.id!;
    if (_isLiked) {
      final like = (await client.articleLike.getLikedArticlesByUser(userId))
          .firstWhere((like) => like.articleId == widget.article.id);
      await client.articleLike.unlikeArticle(like);
    } else {
      final like = ArticleLike(userId: userId, articleId: widget.article.id!);
      await client.articleLike.likeArticle(like);
    }
    setState(() {
      _isLiked = !_isLiked;
    });
    widget.onArticleUpdated();
  }

  Future<void> _shareArticle() async {
    final url = "https://example.com/article/${widget.article.id}";
    await client.article.shareArticle(widget.article.id!);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Share Article"),
        content: Row(
          children: [
            Expanded(child: Text(url)),
            IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: url));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("URL copied!")));
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
    widget.onArticleUpdated();
  }

  Future<void> _addComment() async {
    if (_commentController.text.isNotEmpty) {
      final comment = Comment(
        articleId: widget.article.id!,
        userId: sessionManager.signedInUser!.id!,
        comment: _commentController.text, 
        createdAt: DateTime.now(),
      );
      await client.comment.insertComment(comment);
      _commentController.clear();
      setState(() {});
      widget.onArticleUpdated();
    }
  }

  Future<void> _deleteArticle() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text("Are you sure you want to delete '${widget.article.title}'?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              await client.article.deleteArticle(widget.article);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to ArticleContent
              widget.onArticleUpdated();
            },
            child: Text("Delete"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = sessionManager.signedInUser!.id!;
    final isAuthor = widget.article.authorId == currentUserId;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
        actions: [
          if (isAuthor)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: _deleteArticle,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.article.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            FutureBuilder<String>(
              future: _getUserName(widget.article.authorId),
              builder: (context, snapshot) {
                final authorName = snapshot.data ?? 'Unknown';
                final isCurrentUserAuthor = widget.article.authorId == currentUserId;
                return Text(
                  "By: $authorName${isCurrentUserAuthor ? ' (You)' : ''}",
                  style: TextStyle(color: Colors.grey),
                );
              },
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: QuillEditor(
                controller: _quillController,
                scrollController: ScrollController(),
                focusNode: FocusNode(),
                config: QuillEditorConfig(
                  autoFocus: false,
                  expands: false,
                  padding: EdgeInsets.zero,
                  scrollable: false,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite, color: _isLiked ? Colors.blue : Colors.grey),
                      onPressed: _toggleLike,
                    ),
                    FutureBuilder<int>(
                      future: client.articleLike.getLikeCount(widget.article.id!),
                      builder: (_, snap) => Text(snap.data?.toString() ?? "0"),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: _shareArticle,
                    ),
                    Text("${widget.article.shares}"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Comments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            FutureBuilder<List<Comment>>(
              future: client.comment.getCommentsByArticle(widget.article.id!),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final comments = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return FutureBuilder<String>(
                      future: _getUserName(comment.userId),
                      builder: (context, userSnapshot) {
                        final commenterName = userSnapshot.data ?? 'Unknown';
                        return ListTile(
                          title: Text(comment.comment),
                          subtitle: Text("By: $commenterName - ${comment.createdAt}"),
                        );
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: "Add a comment",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quillController.dispose();
    _commentController.dispose();
    super.dispose();
  }
}