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
import 'package:authinticationproj_client/src/protocol/user.dart' as _i4;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i5;
import 'protocol.dart' as _i6;

/// The `ArticleEndpoint` class provides functionality for managing articles,
/// including fetching recent articles, liking articles, adding comments, and sharing articles.
/// fetching articles by author, editing or deleting
/// articles, and previewing articles.
/// {@category Endpoint}
class EndpointArticle extends _i1.EndpointRef {
  EndpointArticle(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'article';

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
  _i2.Future<List<_i3.Article>> fetchRecentArticles() =>
      caller.callServerEndpoint<List<_i3.Article>>(
        'article',
        'fetchRecentArticles',
        {},
      );

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
  _i2.Future<void> likeArticle(
    int userId,
    int articleId,
  ) =>
      caller.callServerEndpoint<void>(
        'article',
        'likeArticle',
        {
          'userId': userId,
          'articleId': articleId,
        },
      );

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
  _i2.Future<void> addCommentToArticle(
    int userId,
    int articleId,
    String comment,
  ) =>
      caller.callServerEndpoint<void>(
        'article',
        'addCommentToArticle',
        {
          'userId': userId,
          'articleId': articleId,
          'comment': comment,
        },
      );

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
  _i2.Future<void> shareArticle(
    int userId,
    int articleId,
  ) =>
      caller.callServerEndpoint<void>(
        'article',
        'shareArticle',
        {
          'userId': userId,
          'articleId': articleId,
        },
      );

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
  _i2.Future<List<_i3.Article>> fetchArticlesByConsultant(int userId) =>
      caller.callServerEndpoint<List<_i3.Article>>(
        'article',
        'fetchArticlesByConsultant',
        {'userId': userId},
      );

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
  _i2.Future<void> manageArticle(
    int userId,
    int articleId, {
    String? newTitle,
    String? newContent,
    bool? archive,
    bool? delete,
  }) =>
      caller.callServerEndpoint<void>(
        'article',
        'manageArticle',
        {
          'userId': userId,
          'articleId': articleId,
          'newTitle': newTitle,
          'newContent': newContent,
          'archive': archive,
          'delete': delete,
        },
      );

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
  _i2.Future<_i3.Article?> previewArticle(int articleId) =>
      caller.callServerEndpoint<_i3.Article?>(
        'article',
        'previewArticle',
        {'articleId': articleId},
      );
}

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointOpenAI extends _i1.EndpointRef {
  EndpointOpenAI(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'openAI';

  _i2.Future<Object?> getAIResponse(String userMessage) =>
      caller.callServerEndpoint<Object?>(
        'openAI',
        'getAIResponse',
        {'userMessage': userMessage},
      );
}

/// The `UserEndpoint` class provides endpoints for managing user-related operations.
/// This includes fetching user details, updating user information, and creating new users.
/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// Fetches a user by their unique `userId`.
  ///
  /// Parameters:
  /// - `session`: The current server session.
  /// - `userId`: The unique identifier of the user to fetch.
  ///
  /// Returns:
  /// - A `User` object if the user is found.
  /// - `null` if no user is found with the provided `userId`.
  ///
  /// Example:
  /// ```dart
  /// final user = await user.getUser(session, 123);
  /// ```
  _i2.Future<_i4.User?> getUser(int userId) =>
      caller.callServerEndpoint<_i4.User?>(
        'user',
        'getUser',
        {'userId': userId},
      );

  /// Updates an existing user's information in the database.
  ///
  /// Parameters:
  /// - `session`: The current server session.
  /// - `newUser`: A `User` object containing the updated user information.
  ///
  /// Returns:
  /// - The updated `User` object if the update is successful.
  /// - `null` if the user does not exist or the update fails.
  ///
  /// Example:
  /// ```dart
  /// final updatedUser = await user.updateUser(session, user);
  /// ```
  _i2.Future<_i4.User?> updateUser(_i4.User newUser) =>
      caller.callServerEndpoint<_i4.User?>(
        'user',
        'updateUser',
        {'newUser': newUser},
      );

  /// Creates a new user in the database.
  ///
  /// Parameters:
  /// - `session`: The current server session.
  /// - `newUser`: A `User` object containing the details of the new user.
  ///
  /// Returns:
  /// - The newly created `User` object if the insertion is successful.
  /// - `null` if the insertion fails.
  ///
  /// Example:
  /// ```dart
  /// final createdUser = await user.createUser(session, user);
  /// ```
  _i2.Future<_i4.User?> createUser(_i4.User newUser) =>
      caller.callServerEndpoint<_i4.User?>(
        'user',
        'createUser',
        {'newUser': newUser},
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
    article = EndpointArticle(this);
    example = EndpointExample(this);
    openAI = EndpointOpenAI(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointArticle article;

  late final EndpointExample example;

  late final EndpointOpenAI openAI;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'article': article,
        'example': example,
        'openAI': openAI,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
