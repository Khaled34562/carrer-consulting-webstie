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
import '../endpoints/article_endpoint.dart' as _i2;
import '../endpoints/example_endpoint.dart' as _i3;
import '../endpoints/openai_endpoint.dart' as _i4;
import '../endpoints/user.dart' as _i5;
import 'package:authinticationproj_server/src/generated/user.dart' as _i6;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i7;

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
      'example': _i3.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'openAI': _i4.OpenAIEndpoint(apiKey: '')
        ..initialize(
          server,
          'openAI',
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
        'fetchRecentArticles': _i1.MethodConnector(
          name: 'fetchRecentArticles',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint)
                  .fetchRecentArticles(session),
        ),
        'likeArticle': _i1.MethodConnector(
          name: 'likeArticle',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'articleId': _i1.ParameterDescription(
              name: 'articleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint).likeArticle(
            session,
            params['userId'],
            params['articleId'],
          ),
        ),
        'addCommentToArticle': _i1.MethodConnector(
          name: 'addCommentToArticle',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'articleId': _i1.ParameterDescription(
              name: 'articleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint).addCommentToArticle(
            session,
            params['userId'],
            params['articleId'],
            params['comment'],
          ),
        ),
        'shareArticle': _i1.MethodConnector(
          name: 'shareArticle',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'articleId': _i1.ParameterDescription(
              name: 'articleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint).shareArticle(
            session,
            params['userId'],
            params['articleId'],
          ),
        ),
        'fetchArticlesByConsultant': _i1.MethodConnector(
          name: 'fetchArticlesByConsultant',
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
                  .fetchArticlesByConsultant(
            session,
            params['userId'],
          ),
        ),
        'manageArticle': _i1.MethodConnector(
          name: 'manageArticle',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'articleId': _i1.ParameterDescription(
              name: 'articleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newTitle': _i1.ParameterDescription(
              name: 'newTitle',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'newContent': _i1.ParameterDescription(
              name: 'newContent',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'archive': _i1.ParameterDescription(
              name: 'archive',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'delete': _i1.ParameterDescription(
              name: 'delete',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['article'] as _i2.ArticleEndpoint).manageArticle(
            session,
            params['userId'],
            params['articleId'],
            newTitle: params['newTitle'],
            newContent: params['newContent'],
            archive: params['archive'],
            delete: params['delete'],
          ),
        ),
        'previewArticle': _i1.MethodConnector(
          name: 'previewArticle',
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
              (endpoints['article'] as _i2.ArticleEndpoint).previewArticle(
            session,
            params['articleId'],
          ),
        ),
      },
    );
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i3.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['openAI'] = _i1.EndpointConnector(
      name: 'openAI',
      endpoint: endpoints['openAI']!,
      methodConnectors: {
        'getAIResponse': _i1.MethodConnector(
          name: 'getAIResponse',
          params: {
            'userMessage': _i1.ParameterDescription(
              name: 'userMessage',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['openAI'] as _i4.OpenAIEndpoint).getAIResponse(
            session,
            params['userMessage'],
          ),
        )
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getUser': _i1.MethodConnector(
          name: 'getUser',
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
              (endpoints['user'] as _i5.UserEndpoint).getUser(
            session,
            params['userId'],
          ),
        ),
        'updateUser': _i1.MethodConnector(
          name: 'updateUser',
          params: {
            'newUser': _i1.ParameterDescription(
              name: 'newUser',
              type: _i1.getType<_i6.User>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint).updateUser(
            session,
            params['newUser'],
          ),
        ),
        'createUser': _i1.MethodConnector(
          name: 'createUser',
          params: {
            'newUser': _i1.ParameterDescription(
              name: 'newUser',
              type: _i1.getType<_i6.User>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint).createUser(
            session,
            params['newUser'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i7.Endpoints()..initializeEndpoints(server);
  }
}
