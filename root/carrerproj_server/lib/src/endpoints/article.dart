import 'package:authinticationproj_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';


/// Endpoint for handling article-related operations.
class ArticleEndpoint extends Endpoint {
  /// Inserts a new article into the database.
  ///
  /// - [article]: The [Article] object containing article details.
  ///
  /// Returns the inserted [Article] object.
  ///
  /// Example usage:
  /// ```dart
  /// Article newArticle = Article(title: 'New Post', content: 'Content here...');
  /// Article result = await client.article.insertArticle(newArticle);
  /// ```
  Future<Article> insertArticle(Session session, Article article) async {
    return await Article.db.insertRow(session, article);
  }

  /// Retrieves the 10 most recent articles.
  ///
  /// - Articles are sorted in descending order based on `createdAt`.
  ///
  /// Returns a list of up to 10 [Article] objects.
  ///
  /// Example usage:
  /// ```dart
  /// List<Article> recentArticles = await client.article.getRecentArticles();
  /// ```
  Future<List<Article>> getRecentArticles(Session session) async {
    return await Article.db.find(
      session,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 10,
    );
  }

  /// Increments the share count of an article.
  ///
  /// - [articleId]: The unique identifier of the article to be shared.
  /// - If the article is not found, an exception is thrown.
  ///
  /// Returns the updated [Article] object.
  ///
  /// Example usage:
  /// ```dart
  /// Article sharedArticle = await client.article.shareArticle(articleId);
  /// ```
  Future<Article> shareArticle(Session session, int articleId) async {
    final article = await Article.db.findById(session, articleId);
    if (article == null) throw Exception('Article not found');

    article.shares += 1;
    return await Article.db.updateRow(session, article);
  }

  /// Retrieves all articles authored by a specific consultant (user).
  ///
  /// - [userId]: The unique identifier of the consultant (author).
  ///
  /// Returns a list of [Article] objects.
  ///
  /// Example usage:
  /// ```dart
  /// List<Article> consultantArticles = await client.article.getArticlesByConsultant(userId);
  /// ```
  Future<List<Article>> getArticlesByConsultant(
      Session session, int userId) async {
    return await Article.db.find(
      session,
      where: (t) => t.authorId.equals(userId),
    );
  }

  /// Updates an existing article.
  ///
  /// - [updatedArticle]: The updated [Article] object.
  ///
  /// Returns the updated [Article] object.
  ///
  /// Example usage:
  /// ```dart
  /// Article updatedArticle = await client.article.updateArticle(article);
  /// ```
  Future<Article> updateArticle(Session session, Article updatedArticle) async {
    return await Article.db.updateRow(session, updatedArticle);
  }

  /// Retrieves a specific article by its ID.
  ///
  /// - [articleId]: The unique identifier of the article.
  ///
  /// Returns the [Article] object if found, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// Article? article = await client.article.getArticle(articleId);
  /// ```
  Future<Article?> getArticle(Session session, int articleId) async {
    return await Article.db.findById(session, articleId);
  }

  /// Deletes an existing article from the database.
  ///
  /// - [article]: The [Article] object to be deleted.
  /// - If the article is not found, an exception is thrown.
  ///
  /// Returns the deleted [Article] object.
  ///
  /// Example usage:
  /// ```dart
  /// Article articleToDelete = await client.article.getArticle(articleId);
  /// if (articleToDelete != null) {
  ///   await client.article.deleteArticle(articleToDelete);
  /// }
  /// ```
  Future<Article> deleteArticle(Session session, Article article) async {
    return await Article.db.deleteRow(session, article);
  }
}
