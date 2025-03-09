/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:authinticationproj_client/src/protocol/article_like.dart'
    as _i3;
import 'package:authinticationproj_client/src/protocol/comment.dart' as _i4;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i5;
import 'protocol.dart' as _i6;

/// Endpoint for handling article likes.
/// {@category Endpoint}
class EndpointArticleLike extends _i1.EndpointRef {
  EndpointArticleLike(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'articleLike';

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
  _i2.Future<_i3.ArticleLike> likeArticle(_i3.ArticleLike like) =>
      caller.callServerEndpoint<_i3.ArticleLike>(
        'articleLike',
        'likeArticle',
        {'like': like},
      );

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
  _i2.Future<_i3.ArticleLike> unlikeArticle(_i3.ArticleLike like) =>
      caller.callServerEndpoint<_i3.ArticleLike>(
        'articleLike',
        'unlikeArticle',
        {'like': like},
      );

  /// Retrieves all articles liked by a specific user.
  ///
  /// - [like]: The [ArticleLike] object containing `userId`.
  /// - Returns a list of [ArticleLike] objects representing the liked articles.
  ///
  /// Example usage:
  /// ```dart
  /// List<ArticleLike> likedArticles = await client.articleLike.getLikedArticlesByUser(userLike);
  /// ```
  _i2.Future<List<_i3.ArticleLike>> getLikedArticlesByUser(
          _i3.ArticleLike like) =>
      caller.callServerEndpoint<List<_i3.ArticleLike>>(
        'articleLike',
        'getLikedArticlesByUser',
        {'like': like},
      );

  /// Retrieves the total like count for a specific article.
  ///
  /// - [like]: The [ArticleLike] object containing `articleId`.
  /// - Returns an `int` representing the total number of likes.
  ///
  /// Example usage:
  /// ```dart
  /// int likeCount = await client.articleLike.getLikeCount(articleLike);
  /// ```
  _i2.Future<int> getLikeCount(_i3.ArticleLike like) =>
      caller.callServerEndpoint<int>(
        'articleLike',
        'getLikeCount',
        {'like': like},
      );
}

/// Endpoint for handling comment-related operations.
/// {@category Endpoint}
class EndpointComment extends _i1.EndpointRef {
  EndpointComment(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'comment';

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
  _i2.Future<_i4.Comment> insertComment(_i4.Comment comment) =>
      caller.callServerEndpoint<_i4.Comment>(
        'comment',
        'insertComment',
        {'comment': comment},
      );

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
  _i2.Future<List<_i4.Comment>> getCommentsByArticle(int articleId) =>
      caller.callServerEndpoint<List<_i4.Comment>>(
        'comment',
        'getCommentsByArticle',
        {'articleId': articleId},
      );

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
  _i2.Future<List<_i4.Comment>> getCommentsByUser(int userId) =>
      caller.callServerEndpoint<List<_i4.Comment>>(
        'comment',
        'getCommentsByUser',
        {'userId': userId},
      );

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
  _i2.Future<_i4.Comment> deleteComment(_i4.Comment comment) =>
      caller.callServerEndpoint<_i4.Comment>(
        'comment',
        'deleteComment',
        {'comment': comment},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i5.Caller(client);
  }

  late final _i5.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i6.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    articleLike = EndpointArticleLike(this);
    comment = EndpointComment(this);
    modules = Modules(this);
  }

  late final EndpointArticleLike articleLike;

  late final EndpointComment comment;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'articleLike': articleLike,
        'comment': comment,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
