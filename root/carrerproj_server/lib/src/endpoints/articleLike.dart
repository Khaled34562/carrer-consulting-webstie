import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint for handling article likes.
class ArticleLikeEndpoint extends Endpoint {
  /// Likes an article or re-likes it if previously unliked.
  ///
  /// - [like]: The [ArticleLike] object containing `userId` and `articleId`.
  /// - If the like already exists, this may result in a duplicate entry.
  ///
  /// Returns the created [ArticleLike] object.
  ///
  /// Example usage:
  /// ```dart
  /// ArticleLike result = await client.articleLike.likeArticle(ArticleLike: newLike);
  /// ```
  Future<ArticleLike> likeArticle(Session session, ArticleLike like) async {
    like.createdAt = new DateTime.now();
    return await session.db.insertRow(like);
  }

  /// Unlikes an article.
  ///
  /// - [like]: The [ArticleLike] object containing `userId` and `articleId` to be unliked.
  ///
  /// Returns the deleted [ArticleLike] object.
  ///
  /// Example usage:
  /// ```dart
  /// ArticleLike result = await client.articleLike.unlikeArticle(ArticleLike: unlike);
  /// ```
  Future<ArticleLike> unlikeArticle(Session session, ArticleLike like) async {
    return await ArticleLike.db.deleteRow(session, like);
  }

  /// Retrieves all articles liked by a specific user.
  ///
  /// - [userId]: The unique identifier of the user.
  /// - Returns a list of [ArticleLike] objects representing the liked articles.
  ///
  /// Example usage:
  /// ```dart
  /// List<ArticleLike> likedArticles = await client.articleLike.getLikedArticlesByUser(1);
  /// ```
  Future<List<ArticleLike>> getLikedArticlesByUser(
      Session session, int userId) async {
    return await ArticleLike.db
        .find(session, where: (t) => t.userId.equals(userId));
  }

  /// Retrieves the total count of likes for a specific article.
  ///
  /// - [articleId]: The unique identifier of the article.
  /// - Returns an integer representing the total number of likes.
  ///
  /// Example usage:
  /// ```dart
  /// int likeCount = await client.articleLike.getLikeCount(5);
  /// ```
  Future<int> getLikeCount(Session session, int articleId) async {
    return await ArticleLike.db
        .count(session, where: (t) => t.articleId.equals(articleId));
  }
}
