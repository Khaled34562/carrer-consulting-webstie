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
import 'package:carrerproj_client/src/protocol/article.dart' as _i3;
import 'package:carrerproj_client/src/protocol/article_like.dart' as _i4;
import 'package:carrerproj_client/src/protocol/chat_message.dart' as _i5;
import 'package:carrerproj_client/src/protocol/comment.dart' as _i6;
import 'package:carrerproj_client/src/protocol/credential.dart' as _i7;
import 'package:carrerproj_client/src/protocol/user_profile.dart' as _i8;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i9;
import 'protocol.dart' as _i10;

/// Endpoint for handling article-related operations.
/// {@category Endpoint}
class EndpointArticle extends _i1.EndpointRef {
  EndpointArticle(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'article';

  /// Inserts a new article into the database.
  ///
  /// - [article]: The [Article] object containing article details.
  /// - [session]: The current [Session] object.
  ///
  /// Returns the inserted [Article] object.
  ///
  /// Example usage:
  /// ```dart
  /// Article result = await client.article.insertArticle(Article: newArticle);
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
  /// - [session]: The current [Session] object.
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
  /// - [session]: The current [Session] object.
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
  /// - [session]: The current [Session] object.
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
  /// - [session]: The current [Session] object.
  ///
  /// Returns the updated [Article] object.
  ///
  /// Example usage:
  /// ```dart
  /// Article updatedArticle = await client.article.updateArticle(Article: article);
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
  /// - [session]: The current [Session] object.
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
  /// - [session]: The current [Session] object.
  /// - If the article is not found, an exception is thrown.
  ///
  /// Returns the deleted [Article] object.
  ///
  /// Example usage:
  /// ```dart
  /// Article articleToDelete = await client.article.getArticle(Article: article);
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
  /// ArticleLike result = await client.articleLike.likeArticle(ArticleLike: newLike);
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
  /// ArticleLike result = await client.articleLike.unlikeArticle(ArticleLike: unlike);
  /// ```
  _i2.Future<_i4.ArticleLike> unlikeArticle(_i4.ArticleLike like) =>
      caller.callServerEndpoint<_i4.ArticleLike>(
        'articleLike',
        'unlikeArticle',
        {'like': like},
      );

  /// Retrieves all articles liked by a specific user.
  ///
  /// - [userId]: The unique identifier of the user.
  /// - Returns a list of [ArticleLike] objects representing the liked articles.
  ///
  /// Example usage:
  /// ```dart
  /// List<ArticleLike> likedArticles = await client.articleLike.getLikedArticlesByUser(1);
  /// ```
  _i2.Future<List<_i4.ArticleLike>> getLikedArticlesByUser(int userId) =>
      caller.callServerEndpoint<List<_i4.ArticleLike>>(
        'articleLike',
        'getLikedArticlesByUser',
        {'userId': userId},
      );

  /// Retrieves the total count of likes for a specific article.
  ///
  /// - [articleId]: The unique identifier of the article.
  /// - Returns an integer representing the total number of likes.
  ///
  /// Example usage:
  /// ```dart
  /// int likeCount = await client.articleLike.getLikeCount(5);
  /// ```
  _i2.Future<int> getLikeCount(int articleId) => caller.callServerEndpoint<int>(
        'articleLike',
        'getLikeCount',
        {'articleId': articleId},
      );
}

/// Endpoint for handling direct message operations between users.
/// {@category Endpoint}
class EndpointChat extends _i1.EndpointRef {
  EndpointChat(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  /// Sends a direct message to another user.
  ///
  /// - [session]: The current [Session] object.
  /// - [message]: The [Message] object containing details such as sender ID, receiver ID, content, and timestamp.
  ///
  /// Saves the message to the database and broadcasts it to the appropriate channel.
  /// Returns `true` if the message is successfully broadcasted.
  _i2.Future<bool> sendDirectMessage(_i5.ChatMessage message) =>
      caller.callServerEndpoint<bool>(
        'chat',
        'sendDirectMessage',
        {'message': message},
      );

  /// Observes messages exchanged between two specific users in real-time.
  ///
  /// - [session]: The current [Session] object.
  /// - [userId1]: The first user's unique identifier.
  /// - [userId2]: The second user's unique identifier.
  ///
  /// Returns a stream of [ChatMessage] objects as they are sent.
  _i2.Future<_i2.Stream<_i5.ChatMessage>> observeDirectMessages(
    int userId1,
    int userId2,
  ) =>
      caller.callServerEndpoint<_i2.Stream<_i5.ChatMessage>>(
        'chat',
        'observeDirectMessages',
        {
          'userId1': userId1,
          'userId2': userId2,
        },
      );

  /// Retrieves the message history between two users.
  ///
  /// - [session]: The current [Session] object.
  /// - [userId1]: The first user's unique identifier.
  /// - [userId2]: The second user's unique identifier.
  ///
  /// Messages are retrieved in ascending order based on `sentAt` timestamp.
  /// Returns a list of [ChatMessage] objects, with a maximum of 50 messages.
  _i2.Future<List<_i5.ChatMessage>> getDirectMessageHistory(
    int userId1,
    int userId2,
  ) =>
      caller.callServerEndpoint<List<_i5.ChatMessage>>(
        'chat',
        'getDirectMessageHistory',
        {
          'userId1': userId1,
          'userId2': userId2,
        },
      );

  /// Marks messages as read between a sender and a receiver.
  ///
  /// - [session]: The current [Session] object.
  /// - [senderId]: The sender's unique identifier.
  /// - [receiverId]: The receiver's unique identifier.
  ///
  /// **Note:** This method is currently not implemented.
  _i2.Future<void> markMessagesAsRead(
    int senderId,
    int receiverId,
  ) =>
      caller.callServerEndpoint<void>(
        'chat',
        'markMessagesAsRead',
        {
          'senderId': senderId,
          'receiverId': receiverId,
        },
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
  /// - [comment]: The [Comment] object containing necessary details such as `articleId`, `userId`, and `content`.
  ///   The `createdAt` timestamp is automatically set to the current time.
  /// - [session]: The current [Session] object.
  ///
  /// Returns the inserted [Comment] object.
  ///
  /// Example usage:
  /// ```dart
  /// Comment result = await client.comment.insertComment(Comment: newComment);
  /// ```
  _i2.Future<_i6.Comment> insertComment(_i6.Comment comment) =>
      caller.callServerEndpoint<_i6.Comment>(
        'comment',
        'insertComment',
        {'comment': comment},
      );

  /// Retrieves all comments associated with a specific article.
  ///
  /// - [articleId]: The unique identifier of the article.
  /// - [session]: The current [Session] object.
  /// - Comments are returned in ascending order based on `createdAt`.
  ///
  /// Returns a list of [Comment] objects.
  ///
  /// Example usage:
  /// ```dart
  /// List<Comment> comments = await client.comment.getCommentsByArticle(articleId);
  /// ```
  _i2.Future<List<_i6.Comment>> getCommentsByArticle(int articleId) =>
      caller.callServerEndpoint<List<_i6.Comment>>(
        'comment',
        'getCommentsByArticle',
        {'articleId': articleId},
      );

  /// Retrieves all comments made by a specific user.
  ///
  /// - [userId]: The unique identifier of the user.
  /// - [session]: The current [Session] object.
  /// - Comments are returned in ascending order based on `createdAt`.
  ///
  /// Returns a list of [Comment] objects.
  ///
  /// Example usage:
  /// ```dart
  /// List<Comment> userComments = await client.comment.getCommentsByUser(userId);
  /// ```
  _i2.Future<List<_i6.Comment>> getCommentsByUser(int userId) =>
      caller.callServerEndpoint<List<_i6.Comment>>(
        'comment',
        'getCommentsByUser',
        {'userId': userId},
      );

  /// Deletes a specific comment from the database.
  ///
  /// - [comment]: The [Comment] object to be deleted.
  /// - [session]: The current [Session] object.
  ///
  /// Returns the deleted [Comment] object.
  ///
  /// Example usage:
  /// ```dart
  /// Comment result = await client.comment.deleteComment(Comment: commentToDelete);
  /// ```
  _i2.Future<_i6.Comment> deleteComment(_i6.Comment comment) =>
      caller.callServerEndpoint<_i6.Comment>(
        'comment',
        'deleteComment',
        {'comment': comment},
      );
}

/// Endpoint for handling credential-related operations.
/// {@category Endpoint}
class EndpointCredentials extends _i1.EndpointRef {
  EndpointCredentials(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'credentials';

  /// Creates a new credential for a user.
  _i2.Future<_i7.Credentials?> createCredential(_i7.Credentials credential) =>
      caller.callServerEndpoint<_i7.Credentials?>(
        'credentials',
        'createCredential',
        {'credential': credential},
      );

  /// Retrieves all credentials for a specific user.
  _i2.Future<List<_i7.Credentials>> getCredentialsByUserId(int userId) =>
      caller.callServerEndpoint<List<_i7.Credentials>>(
        'credentials',
        'getCredentialsByUserId',
        {'userId': userId},
      );

  /// Updates an existing credential.
  _i2.Future<_i7.Credentials?> updateCredential(_i7.Credentials credential) =>
      caller.callServerEndpoint<_i7.Credentials?>(
        'credentials',
        'updateCredential',
        {'credential': credential},
      );

  /// Deletes a credential.
  _i2.Future<_i7.Credentials> deleteCredential(_i7.Credentials credential) =>
      caller.callServerEndpoint<_i7.Credentials>(
        'credentials',
        'deleteCredential',
        {'credential': credential},
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
  /// UserProfile? user = await client.user.getUserProfile(userId);
  /// ```
  _i2.Future<_i8.UserProfile?> getUserProfile(int userId) =>
      caller.callServerEndpoint<_i8.UserProfile?>(
        'user',
        'getUserProfile',
        {'userId': userId},
      );

  /// Updates an existing user profile with the provided [updatedUser] object.
  ///
  /// Returns the updated [UserProfile] if successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile? result = await client.user.updateUserProfile(UserProfile: updatedUserProfile);
  /// ```
  _i2.Future<_i8.UserProfile?> updateUserProfile(
          _i8.UserProfile updatedUserProfile) =>
      caller.callServerEndpoint<_i8.UserProfile?>(
        'user',
        'updateUserProfile',
        {'updatedUserProfile': updatedUserProfile},
      );

  /// Creates a new user profile using the [newUser] object.
  ///
  /// Returns the created [UserProfile] if successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile? result = await client.user.createUserProfile(UserProfile: newUserProfile);
  /// ```
  _i2.Future<_i8.UserProfile?> createUserProfile(
          _i8.UserProfile newUserProfile) =>
      caller.callServerEndpoint<_i8.UserProfile?>(
        'user',
        'createUserProfile',
        {'newUserProfile': newUserProfile},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i9.Caller(client);
  }

  late final _i9.Caller auth;
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
          _i10.Protocol(),
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
    chat = EndpointChat(this);
    comment = EndpointComment(this);
    credentials = EndpointCredentials(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointArticle article;

  late final EndpointArticleLike articleLike;

  late final EndpointChat chat;

  late final EndpointComment comment;

  late final EndpointCredentials credentials;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'article': article,
        'articleLike': articleLike,
        'chat': chat,
        'comment': comment,
        'credentials': credentials,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
