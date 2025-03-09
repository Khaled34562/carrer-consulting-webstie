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
  /// ArticleLike newLike = ArticleLike(userId: 1, articleId: 5);
  /// ArticleLike result = await client.articleLike.likeArticle(newLike);
  /// ```
  Future<ArticleLike> likeArticle(Session session, ArticleLike like) async {
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
  /// ArticleLike unlike = ArticleLike(userId: 1, articleId: 5);
  /// ArticleLike result = await client.articleLike.unlikeArticle(unlike);
  /// ```
  Future<ArticleLike> unlikeArticle(Session session, ArticleLike like) async {
    return await ArticleLike.db.deleteRow(session, like);
  }

  /// Retrieves all articles liked by a specific user.
  ///
  /// - [like]: The [ArticleLike] object containing `userId`.
  /// - Returns a list of [ArticleLike] objects representing the liked articles.
  ///
  /// Example usage:
  /// ```dart
  /// List<ArticleLike> likedArticles = await client.articleLike.getLikedArticlesByUser(userLike);
  /// ```
  Future<List<ArticleLike>> getLikedArticlesByUser(
      Session session, ArticleLike like) async {
    return await ArticleLike.db
        .find(session, where: (t) => t.userId.equals(like.userId));
  }

  /// Retrieves the total like count for a specific article.
  ///
  /// - [like]: The [ArticleLike] object containing `articleId`.
  /// - Returns an `int` representing the total number of likes.
  ///
  /// Example usage:
  /// ```dart
  /// int likeCount = await client.articleLike.getLikeCount(articleLike);
  /// ```
  Future<int> getLikeCount(Session session, ArticleLike like) async {
    return await ArticleLike.db
        .count(session, where: (t) => t.articleId.equals(like.articleId));
  }
}
