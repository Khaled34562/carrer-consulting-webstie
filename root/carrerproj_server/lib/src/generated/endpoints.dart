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
import '../endpoints/articleLike.dart' as _i3;
import '../endpoints/comment.dart' as _i4;
import '../endpoints/userProfile.dart' as _i5;
import 'package:authinticationproj_server/src/generated/article.dart' as _i6;
import 'package:authinticationproj_server/src/generated/article_like.dart'
    as _i7;
import 'package:authinticationproj_server/src/generated/comment.dart' as _i8;
import 'package:authinticationproj_server/src/generated/user_profile.dart'
    as _i9;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i10;

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
      'comment': _i4.CommentEndpoint()
        ..initialize(
          server,
          'comment',
          null,
        ),
      'user': _i5.UserEndpoint()
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
              type: _i1.getType<_i6.Article>(),
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
              type: _i1.getType<_i6.Article>(),
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
              type: _i1.getType<_i6.Article>(),
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
              type: _i1.getType<_i7.ArticleLike>(),
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
              type: _i1.getType<_i7.ArticleLike>(),
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
    connectors['comment'] = _i1.EndpointConnector(
      name: 'comment',
      endpoint: endpoints['comment']!,
      methodConnectors: {
        'insertComment': _i1.MethodConnector(
          name: 'insertComment',
          params: {
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<_i8.Comment>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['comment'] as _i4.CommentEndpoint).insertComment(
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
              (endpoints['comment'] as _i4.CommentEndpoint)
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
              (endpoints['comment'] as _i4.CommentEndpoint).getCommentsByUser(
            session,
            params['userId'],
          ),
        ),
        'deleteComment': _i1.MethodConnector(
          name: 'deleteComment',
          params: {
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<_i8.Comment>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['comment'] as _i4.CommentEndpoint).deleteComment(
            session,
            params['comment'],
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
              (endpoints['user'] as _i5.UserEndpoint).getUserProfile(
            session,
            params['userId'],
          ),
        ),
        'updateUserProfile': _i1.MethodConnector(
          name: 'updateUserProfile',
          params: {
            'updatedUserProfile': _i1.ParameterDescription(
              name: 'updatedUserProfile',
              type: _i1.getType<_i9.UserProfile>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint).updateUserProfile(
            session,
            params['updatedUserProfile'],
          ),
        ),
        'createUserProfile': _i1.MethodConnector(
          name: 'createUserProfile',
          params: {
            'newUserProfile': _i1.ParameterDescription(
              name: 'newUserProfile',
              type: _i1.getType<_i9.UserProfile>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint).createUserProfile(
            session,
            params['newUserProfile'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i10.Endpoints()..initializeEndpoints(server);
  }
}
