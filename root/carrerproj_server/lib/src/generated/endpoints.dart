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
import '../endpoints/articleLike.dart' as _i2;
import '../endpoints/comment.dart' as _i3;
import 'package:authinticationproj_server/src/generated/article_like.dart'
    as _i4;
import 'package:authinticationproj_server/src/generated/comment.dart' as _i5;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i6;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'articleLike': _i2.ArticleLikeEndpoint()
        ..initialize(
          server,
          'articleLike',
          null,
        ),
      'comment': _i3.CommentEndpoint()
        ..initialize(
          server,
          'comment',
          null,
        ),
    };
    connectors['articleLike'] = _i1.EndpointConnector(
      name: 'articleLike',
      endpoint: endpoints['articleLike']!,
      methodConnectors: {
        'likeArticle': _i1.MethodConnector(
          name: 'likeArticle',
          params: {
            'like': _i1.ParameterDescription(
              name: 'like',
              type: _i1.getType<_i4.ArticleLike>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['articleLike'] as _i2.ArticleLikeEndpoint).likeArticle(
            session,
            params['like'],
          ),
        ),
        'unlikeArticle': _i1.MethodConnector(
          name: 'unlikeArticle',
          params: {
            'like': _i1.ParameterDescription(
              name: 'like',
              type: _i1.getType<_i4.ArticleLike>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['articleLike'] as _i2.ArticleLikeEndpoint)
                  .unlikeArticle(
            session,
            params['like'],
          ),
        ),
        'getLikedArticlesByUser': _i1.MethodConnector(
          name: 'getLikedArticlesByUser',
          params: {
            'like': _i1.ParameterDescription(
              name: 'like',
              type: _i1.getType<_i4.ArticleLike>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['articleLike'] as _i2.ArticleLikeEndpoint)
                  .getLikedArticlesByUser(
            session,
            params['like'],
          ),
        ),
        'getLikeCount': _i1.MethodConnector(
          name: 'getLikeCount',
          params: {
            'like': _i1.ParameterDescription(
              name: 'like',
              type: _i1.getType<_i4.ArticleLike>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['articleLike'] as _i2.ArticleLikeEndpoint)
                  .getLikeCount(
            session,
            params['like'],
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
              type: _i1.getType<_i5.Comment>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['comment'] as _i3.CommentEndpoint).insertComment(
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
              (endpoints['comment'] as _i3.CommentEndpoint)
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
              (endpoints['comment'] as _i3.CommentEndpoint).getCommentsByUser(
            session,
            params['userId'],
          ),
        ),
        'deleteComment': _i1.MethodConnector(
          name: 'deleteComment',
          params: {
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<_i5.Comment>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['comment'] as _i3.CommentEndpoint).deleteComment(
            session,
            params['comment'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i6.Endpoints()..initializeEndpoints(server);
  }
}
