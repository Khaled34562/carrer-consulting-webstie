// Import necessary packages and generated protocol files
import 'package:serverpod/serverpod.dart';
import '../generated/article.dart';
import '../generated/comment.dart';

/// The `ArticleEndpoint` class provides functionality for managing articles,
/// including fetching recent articles, liking articles, adding comments, and sharing articles.
/// fetching articles by author, editing or deleting
/// articles, and previewing articles.
class ArticleEndpoint extends Endpoint {
  /// Fetches the 10 most recent articles from the database, ordered by their creation date
  /// in descending order (newest first).
  ///
  /// - Parameters:
  ///   - `session`: The current Serverpod session, used for database operations.
  ///
  /// - Returns: A `Future<List<Article>>` containing the 10 most recent articles.
  ///
  /// - Example:
  ///   ```dart
  ///   final recentArticles = await article.fetchRecentArticles(session);
  ///   ```
  Future<List<Article>> fetchRecentArticles(Session session) async {
    return await Article.db.find(
      session,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 10,
    );
  }

  /// Increments the like count of a specific article.
  ///
  /// - Parameters:
  ///   - `session`: The current Serverpod session, used for database operations.
  ///   - `userId`: The ID of the user liking the article (currently unused in the method).
  ///   - `articleId`: The ID of the article to like.
  ///
  /// - Throws:
  ///   - `Exception`: If the article with the specified `articleId` is not found.
  ///
  /// - Example:
  ///   ```dart
  ///   await article.likeArticle(session, userId, articleId);
  ///   ```
  Future<void> likeArticle(Session session, int userId, int articleId) async {
    final article = await Article.db.findById(session, articleId);
    if (article == null) throw Exception('Article not found');
    article.likes += 1;
    await Article.db.updateRow(session, article);
  }

  /// Adds a comment to a specific article.
  ///
  /// - Parameters:
  ///   - `session`: The current Serverpod session, used for database operations.
  ///   - `userId`: The ID of the user adding the comment.
  ///   - `articleId`: The ID of the article to which the comment is added.
  ///   - `comment`: The comment text.
  ///
  /// - Example:
  ///   ```dart
  ///   await article.addCommentToArticle(session, userId, articleId, "Great article!");
  ///   ```
  Future<void> addCommentToArticle(
      Session session, int userId, int articleId, String comment) async {
    final newComment = Comment(
      articleId: articleId,
      userId: userId,
      comment: comment,
      createdAt: DateTime.now(),
    );
    await Comment.db.insertRow(session, newComment);
  }

  /// Increments the share count of a specific article.
  ///
  /// - Parameters:
  ///   - `session`: The current Serverpod session, used for database operations.
  ///   - `userId`: The ID of the user sharing the article (currently unused in the method).
  ///   - `articleId`: The ID of the article to share.
  ///
  /// - Throws:
  ///   - `Exception`: If the article with the specified `articleId` is not found.
  ///
  /// - Example:
  ///   ```dart
  ///   await article.shareArticle(session, userId, articleId);
  ///   ```
  Future<void> shareArticle(Session session, int userId, int articleId) async {
    final article = await Article.db.findById(session, articleId);
    if (article == null) throw Exception('Article not found');

    article.shares += 1;
    await Article.db.updateRow(session, article);
  }

  /// Fetches all articles written by a specific consultant.
  ///
  /// Parameters:
  /// - `session`: The current server session.
  /// - `userId`: The unique identifier of the consultant (author) whose articles
  ///   are to be fetched.
  ///
  /// Returns:
  /// - A `List<Article>` containing all articles written by the consultant.
  ///
  /// Example:
  /// ```dart
  /// final articles = await article.fetchArticlesByConsultant(session, 123);
  /// ```
  Future<List<Article>> fetchArticlesByConsultant(
      Session session, int userId) async {
    return await Article.db.find(
      session,
      where: (t) => t.authorId.equals(userId),
    );
  }

  /// Allows a consultant to edit, archive, or delete an article.
  ///
  /// Parameters:
  /// - `session`: The current server session.
  /// - `userId`: The unique identifier of the consultant performing the action.
  /// - `articleId`: The unique identifier of the article to be managed.
  /// - `newTitle`: (Optional) The new title for the article.
  /// - `newContent`: (Optional) The new content for the article.
  /// - `archive`: (Optional) Whether to archive the article.
  /// - `delete`: (Optional) Whether to delete the article.
  ///
  /// Throws:
  /// - `Exception` if the article is not found or the user is unauthorized.
  ///
  /// Example:
  /// ```dart
  /// await article.manageArticle(
  ///   session,
  ///   123,
  ///   456,
  ///   newTitle: 'Updated Title',
  ///   newContent: 'Updated content...',
  ///   archive: true,
  /// );
  /// ```
  Future<void> manageArticle(Session session, int userId, int articleId,
      {String? newTitle,
      String? newContent,
      bool? archive,
      bool? delete}) async {
    // Fetch the article by ID
    final article = await Article.db.findById(session, articleId);
    if (article == null || article.authorId != userId)
      throw Exception('Article not found or unauthorized');

    // Delete the article if requested
    if (delete == true) {
      await Article.db
          .deleteWhere(session, where: (t) => t.id.equals(articleId));
    } else {
      // Update the article fields if provided
      bool isUpdated = false;
      if (newTitle != null) {
        article.title = newTitle;
        isUpdated = true;
      } else if (newContent != null) {
        article.content = newContent;
        isUpdated = true;
      } else if (archive != null) {
        article.isArchived = archive;
        isUpdated = true;
      }
      if (isUpdated) {
        article.updatedAt = DateTime.now();
      }
      await Article.db.updateRow(session, article);
    }
  }

  /// Fetches an article for previewing.
  ///
  /// Parameters:
  /// - `session`: The current server session.
  /// - `articleId`: The unique identifier of the article to preview.
  ///
  /// Returns:
  /// - The `Article` object if found.
  /// - `null` if the article is not found.
  ///
  /// Example:
  /// ```dart
  /// final article = await article.previewArticle(session, 456);
  /// ```
  Future<Article?> previewArticle(Session session, int articleId) async {
    return await Article.db.findById(session, articleId);
  }
}
