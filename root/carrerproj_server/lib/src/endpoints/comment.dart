import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint for handling comment-related operations.
class CommentEndpoint extends Endpoint {
  /// Inserts a new comment into the database.
  ///
  /// The [comment] object should contain necessary details such as `articleId` and `userId`.
  /// The `createdAt` timestamp is automatically set to the current time.
  ///
  /// Returns the inserted [Comment] object.
  ///
  /// Example usage:
  /// ```dart
  /// Comment newComment = Comment(articleId: 1, userId: 2, content: 'Great article!');
  /// Comment result = await client.comment.insertComment(newComment);
  /// ```
  Future<Comment> insertComment(Session session, Comment comment) async {
    comment.createdAt = DateTime.now();
    return await Comment.db.insertRow(session, comment);
  }

  /// Retrieves all comments associated with a specific article.
  ///
  /// - [articleId]: The unique identifier of the article.
  /// - Comments are returned in ascending order based on `createdAt`.
  ///
  /// Returns a list of [Comment] objects.
  ///
  /// Example usage:
  /// ```dart
  /// List<Comment> comments = await client.comment.getCommentsByArticle(articleId);
  /// ```
  Future<List<Comment>> getCommentsByArticle(
      Session session, int articleId) async {
    return await Comment.db.find(
      session,
      where: (t) => t.articleId.equals(articleId),
      orderBy: (t) => t.createdAt,
    );
  }

  /// Retrieves all comments made by a specific user.
  ///
  /// - [userId]: The unique identifier of the user.
  /// - Comments are returned in ascending order based on `createdAt`.
  ///
  /// Returns a list of [Comment] objects.
  ///
  /// Example usage:
  /// ```dart
  /// List<Comment> userComments = await client.comment.getCommentsByUser(userId);
  /// ```
  Future<List<Comment>> getCommentsByUser(Session session, int userId) async {
    return await Comment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
    );
  }

  /// Deletes a specific comment from the database.
  ///
  /// - [comment]: The [Comment] object to be deleted.
  ///
  /// Returns the deleted [Comment] object.
  ///
  /// Example usage:
  /// ```dart
  /// Comment commentToDelete = Comment(id: 5);
  /// Comment result = await client.comment.deleteComment(commentToDelete);
  /// ```
  Future<Comment> deleteComment(Session session, Comment comment) async {
    return await Comment.db.deleteRow(session, comment);
  }
}
