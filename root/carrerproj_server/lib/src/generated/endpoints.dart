/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/article.dart' as _i2;
import '../endpoints/article_like.dart' as _i3;
import '../endpoints/chat.dart' as _i4;
import '../endpoints/comment.dart' as _i5;
import '../endpoints/credential.dart' as _i6;
import '../endpoints/user_profile.dart' as _i7;
import 'package:carrerproj_server/src/generated/article.dart' as _i8;
import 'package:carrerproj_server/src/generated/article_like.dart' as _i9;
import 'package:carrerproj_server/src/generated/chat_message.dart' as _i10;
import 'package:carrerproj_server/src/generated/comment.dart' as _i11;
import 'package:carrerproj_server/src/generated/credential.dart' as _i12;
import 'package:carrerproj_server/src/generated/user_profile.dart' as _i13;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i14;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'article': _i2.ArticleEndpoint()
        ..initialize(
          server,
          'article',
          null,
        ),
      'articleLike': _i3.ArticleLikeEndpoint()
        ..initialize(
          server,
          'articleLike',
          null,
        ),
      'chat': _i4.ChatEndpoint()
        ..initialize(
          server,
          'chat',
          null,
        ),
      'comment': _i5.CommentEndpoint()
        ..initialize(
          server,
          'comment',
          null,
        ),
      'credentials': _i6.CredentialsEndpoint()
        ..initialize(
          server,
          'credentials',
          null,
        ),
      'user': _i7.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['article'] = _i1.EndpointConnector(
      name: 'article',
      endpoint: endpoints['article']!,
      methodConnectors: {
        'insertArticle': _i1.MethodConnector(
          name: 'insertArticle',
          params: {
            'article': _i1.ParameterDescription(
              name: 'article',
              type: _i1.getType<_i8.Article>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint).insertArticle(
            session,
            params['article'],
          ),
        ),
        'getRecentArticles': _i1.MethodConnector(
          name: 'getRecentArticles',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint)
                  .getRecentArticles(session),
        ),
        'shareArticle': _i1.MethodConnector(
          name: 'shareArticle',
          params: {
            'articleId': _i1.ParameterDescription(
              name: 'articleId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint).shareArticle(
            session,
            params['articleId'],
          ),
        ),
        'getArticlesByConsultant': _i1.MethodConnector(
          name: 'getArticlesByConsultant',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint)
                  .getArticlesByConsultant(
            session,
            params['userId'],
          ),
        ),
        'updateArticle': _i1.MethodConnector(
          name: 'updateArticle',
          params: {
            'updatedArticle': _i1.ParameterDescription(
              name: 'updatedArticle',
              type: _i1.getType<_i8.Article>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint).updateArticle(
            session,
            params['updatedArticle'],
          ),
        ),
        'getArticle': _i1.MethodConnector(
          name: 'getArticle',
          params: {
            'articleId': _i1.ParameterDescription(
              name: 'articleId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint).getArticle(
            session,
            params['articleId'],
          ),
        ),
        'deleteArticle': _i1.MethodConnector(
          name: 'deleteArticle',
          params: {
            'article': _i1.ParameterDescription(
              name: 'article',
              type: _i1.getType<_i8.Article>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint).deleteArticle(
            session,
            params['article'],
          ),
        ),
      },
    );
    connectors['articleLike'] = _i1.EndpointConnector(
      name: 'articleLike',
      endpoint: endpoints['articleLike']!,
      methodConnectors: {
        'likeArticle': _i1.MethodConnector(
          name: 'likeArticle',
          params: {
            'like': _i1.ParameterDescription(
              name: 'like',
              type: _i1.getType<_i9.ArticleLike>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['articleLike'] as _i3.ArticleLikeEndpoint).likeArticle(
            session,
            params['like'],
          ),
        ),
        'unlikeArticle': _i1.MethodConnector(
          name: 'unlikeArticle',
          params: {
            'like': _i1.ParameterDescription(
              name: 'like',
              type: _i1.getType<_i9.ArticleLike>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['articleLike'] as _i3.ArticleLikeEndpoint)
                  .unlikeArticle(
            session,
            params['like'],
          ),
        ),
        'getLikedArticlesByUser': _i1.MethodConnector(
          name: 'getLikedArticlesByUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['articleLike'] as _i3.ArticleLikeEndpoint)
                  .getLikedArticlesByUser(
            session,
            params['userId'],
          ),
        ),
        'getLikeCount': _i1.MethodConnector(
          name: 'getLikeCount',
          params: {
            'articleId': _i1.ParameterDescription(
              name: 'articleId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['articleLike'] as _i3.ArticleLikeEndpoint)
                  .getLikeCount(
            session,
            params['articleId'],
          ),
        ),
      },
    );
    connectors['chat'] = _i1.EndpointConnector(
      name: 'chat',
      endpoint: endpoints['chat']!,
      methodConnectors: {
        'sendDirectMessage': _i1.MethodConnector(
          name: 'sendDirectMessage',
          params: {
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<_i10.ChatMessage>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i4.ChatEndpoint).sendDirectMessage(
            session,
            params['message'],
          ),
        ),
        'observeDirectMessages': _i1.MethodConnector(
          name: 'observeDirectMessages',
          params: {
            'userId1': _i1.ParameterDescription(
              name: 'userId1',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId2': _i1.ParameterDescription(
              name: 'userId2',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i4.ChatEndpoint).observeDirectMessages(
            session,
            params['userId1'],
            params['userId2'],
          ),
        ),
        'getDirectMessageHistory': _i1.MethodConnector(
          name: 'getDirectMessageHistory',
          params: {
            'userId1': _i1.ParameterDescription(
              name: 'userId1',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId2': _i1.ParameterDescription(
              name: 'userId2',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i4.ChatEndpoint).getDirectMessageHistory(
            session,
            params['userId1'],
            params['userId2'],
          ),
        ),
        'markMessagesAsRead': _i1.MethodConnector(
          name: 'markMessagesAsRead',
          params: {
            'senderId': _i1.ParameterDescription(
              name: 'senderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'receiverId': _i1.ParameterDescription(
              name: 'receiverId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i4.ChatEndpoint).markMessagesAsRead(
            session,
            params['senderId'],
            params['receiverId'],
          ),
        ),
      },
    );
    connectors['comment'] = _i1.EndpointConnector(
      name: 'comment',
      endpoint: endpoints['comment']!,
      methodConnectors: {
        'insertComment': _i1.MethodConnector(
          name: 'insertComment',
          params: {
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<_i11.Comment>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['comment'] as _i5.CommentEndpoint).insertComment(
            session,
            params['comment'],
          ),
        ),
        'getCommentsByArticle': _i1.MethodConnector(
          name: 'getCommentsByArticle',
          params: {
            'articleId': _i1.ParameterDescription(
              name: 'articleId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['comment'] as _i5.CommentEndpoint)
                  .getCommentsByArticle(
            session,
            params['articleId'],
          ),
        ),
        'getCommentsByUser': _i1.MethodConnector(
          name: 'getCommentsByUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['comment'] as _i5.CommentEndpoint).getCommentsByUser(
            session,
            params['userId'],
          ),
        ),
        'deleteComment': _i1.MethodConnector(
          name: 'deleteComment',
          params: {
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<_i11.Comment>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['comment'] as _i5.CommentEndpoint).deleteComment(
            session,
            params['comment'],
          ),
        ),
      },
    );
    connectors['credentials'] = _i1.EndpointConnector(
      name: 'credentials',
      endpoint: endpoints['credentials']!,
      methodConnectors: {
        'getUploadDescription': _i1.MethodConnector(
          name: 'getUploadDescription',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['credentials'] as _i6.CredentialsEndpoint)
                  .getUploadDescription(
            session,
            params['path'],
          ),
        ),
        'verifyUpload': _i1.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['credentials'] as _i6.CredentialsEndpoint)
                  .verifyUpload(
            session,
            params['path'],
          ),
        ),
        'createCredentialWithFile': _i1.MethodConnector(
          name: 'createCredentialWithFile',
          params: {
            'credential': _i1.ParameterDescription(
              name: 'credential',
              type: _i1.getType<_i12.Credentials>(),
              nullable: false,
            ),
            'filePath': _i1.ParameterDescription(
              name: 'filePath',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['credentials'] as _i6.CredentialsEndpoint)
                  .createCredentialWithFile(
            session,
            params['credential'],
            params['filePath'],
          ),
        ),
        'createCredential': _i1.MethodConnector(
          name: 'createCredential',
          params: {
            'credential': _i1.ParameterDescription(
              name: 'credential',
              type: _i1.getType<_i12.Credentials>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['credentials'] as _i6.CredentialsEndpoint)
                  .createCredential(
            session,
            params['credential'],
          ),
        ),
        'getCredentialsByUserId': _i1.MethodConnector(
          name: 'getCredentialsByUserId',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['credentials'] as _i6.CredentialsEndpoint)
                  .getCredentialsByUserId(
            session,
            params['userId'],
          ),
        ),
        'updateCredentialWithFile': _i1.MethodConnector(
          name: 'updateCredentialWithFile',
          params: {
            'credential': _i1.ParameterDescription(
              name: 'credential',
              type: _i1.getType<_i12.Credentials>(),
              nullable: false,
            ),
            'filePath': _i1.ParameterDescription(
              name: 'filePath',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['credentials'] as _i6.CredentialsEndpoint)
                  .updateCredentialWithFile(
            session,
            params['credential'],
            params['filePath'],
          ),
        ),
        'updateCredential': _i1.MethodConnector(
          name: 'updateCredential',
          params: {
            'credential': _i1.ParameterDescription(
              name: 'credential',
              type: _i1.getType<_i12.Credentials>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['credentials'] as _i6.CredentialsEndpoint)
                  .updateCredential(
            session,
            params['credential'],
          ),
        ),
        'deleteCredential': _i1.MethodConnector(
          name: 'deleteCredential',
          params: {
            'credential': _i1.ParameterDescription(
              name: 'credential',
              type: _i1.getType<_i12.Credentials>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['credentials'] as _i6.CredentialsEndpoint)
                  .deleteCredential(
            session,
            params['credential'],
          ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getUserProfile': _i1.MethodConnector(
          name: 'getUserProfile',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i7.UserEndpoint).getUserProfile(
            session,
            params['userId'],
          ),
        ),
        'updateUserProfile': _i1.MethodConnector(
          name: 'updateUserProfile',
          params: {
            'updatedUserProfile': _i1.ParameterDescription(
              name: 'updatedUserProfile',
              type: _i1.getType<_i13.UserProfile>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i7.UserEndpoint).updateUserProfile(
            session,
            params['updatedUserProfile'],
          ),
        ),
        'createUserProfile': _i1.MethodConnector(
          name: 'createUserProfile',
          params: {
            'newUserProfile': _i1.ParameterDescription(
              name: 'newUserProfile',
              type: _i1.getType<_i13.UserProfile>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i7.UserEndpoint).createUserProfile(
            session,
            params['newUserProfile'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i14.Endpoints()..initializeEndpoints(server);
  }
}
