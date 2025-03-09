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
import 'package:authinticationproj_client/src/protocol/article.dart' as _i3;
import 'package:authinticationproj_client/src/protocol/article_like.dart'
    as _i4;
import 'package:authinticationproj_client/src/protocol/comment.dart' as _i5;
import 'package:authinticationproj_client/src/protocol/user_profile.dart'
    as _i6;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i7;
import 'protocol.dart' as _i8;

/// Endpoint for handling article-related operations.
/// {@category Endpoint}
class EndpointArticle extends _i1.EndpointRef {
  EndpointArticle(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'article';

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
  _i2.Future<_i3.Article> insertArticle(_i3.Article article) =>
      caller.callServerEndpoint<_i3.Article>(
        'article',
        'insertArticle',
        {'article': article},
      );

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
  _i2.Future<List<_i3.Article>> getRecentArticles() =>
      caller.callServerEndpoint<List<_i3.Article>>(
        'article',
        'getRecentArticles',
        {},
      );

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
  _i2.Future<_i3.Article> shareArticle(int articleId) =>
      caller.callServerEndpoint<_i3.Article>(
        'article',
        'shareArticle',
        {'articleId': articleId},
      );

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
  _i2.Future<List<_i3.Article>> getArticlesByConsultant(int userId) =>
      caller.callServerEndpoint<List<_i3.Article>>(
        'article',
        'getArticlesByConsultant',
        {'userId': userId},
      );

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
  _i2.Future<_i3.Article> updateArticle(_i3.Article updatedArticle) =>
      caller.callServerEndpoint<_i3.Article>(
        'article',
        'updateArticle',
        {'updatedArticle': updatedArticle},
      );

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
  _i2.Future<_i3.Article?> getArticle(int articleId) =>
      caller.callServerEndpoint<_i3.Article?>(
        'article',
        'getArticle',
        {'articleId': articleId},
      );

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
  _i2.Future<_i3.Article> deleteArticle(_i3.Article article) =>
      caller.callServerEndpoint<_i3.Article>(
        'article',
        'deleteArticle',
        {'article': article},
      );
}

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
  _i2.Future<_i4.ArticleLike> likeArticle(_i4.ArticleLike like) =>
      caller.callServerEndpoint<_i4.ArticleLike>(
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
  _i2.Future<_i4.ArticleLike> unlikeArticle(_i4.ArticleLike like) =>
      caller.callServerEndpoint<_i4.ArticleLike>(
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
  _i2.Future<List<_i4.ArticleLike>> getLikedArticlesByUser(
          _i4.ArticleLike like) =>
      caller.callServerEndpoint<List<_i4.ArticleLike>>(
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
  _i2.Future<int> getLikeCount(_i4.ArticleLike like) =>
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
  _i2.Future<_i5.Comment> insertComment(_i5.Comment comment) =>
      caller.callServerEndpoint<_i5.Comment>(
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
  _i2.Future<List<_i5.Comment>> getCommentsByArticle(int articleId) =>
      caller.callServerEndpoint<List<_i5.Comment>>(
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
  _i2.Future<List<_i5.Comment>> getCommentsByUser(int userId) =>
      caller.callServerEndpoint<List<_i5.Comment>>(
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
  _i2.Future<_i5.Comment> deleteComment(_i5.Comment comment) =>
      caller.callServerEndpoint<_i5.Comment>(
        'comment',
        'deleteComment',
        {'comment': comment},
      );
}

/// Endpoint for handling user-related operations.
/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// Retrieves a user profile by their [userId].
  ///
  /// Returns a [UserProfile] object if found, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile? user = await client.user.getUser(userId);
  /// ```
  _i2.Future<_i6.UserProfile?> getUser(int userId) =>
      caller.callServerEndpoint<_i6.UserProfile?>(
        'user',
        'getUser',
        {'userId': userId},
      );

  /// Updates an existing user profile with the provided [updatedUser] object.
  ///
  /// Returns the updated [UserProfile] if successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile updatedUser = UserProfile(id: 1, name: 'New Name');
  /// UserProfile? result = await client.user.updateUser(updatedUser);
  /// ```
  _i2.Future<_i6.UserProfile?> updateUser(_i6.UserProfile updatedUser) =>
      caller.callServerEndpoint<_i6.UserProfile?>(
        'user',
        'updateUser',
        {'updatedUser': updatedUser},
      );

  /// Creates a new user profile using the [newUser] object.
  ///
  /// Returns the created [UserProfile] if successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile newUser = UserProfile(name: 'John Doe');
  /// UserProfile? result = await client.user.createUser(newUser);
  /// ```
  _i2.Future<_i6.UserProfile?> createUser(_i6.UserProfile newUser) =>
      caller.callServerEndpoint<_i6.UserProfile?>(
        'user',
        'createUser',
        {'newUser': newUser},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i7.Caller(client);
  }

  late final _i7.Caller auth;
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
          _i8.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    article = EndpointArticle(this);
    articleLike = EndpointArticleLike(this);
    comment = EndpointComment(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointArticle article;

  late final EndpointArticleLike articleLike;

  late final EndpointComment comment;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'article': article,
        'articleLike': articleLike,
        'comment': comment,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
