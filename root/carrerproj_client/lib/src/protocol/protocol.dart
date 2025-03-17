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
import 'article.dart' as _i2;
import 'article_like.dart' as _i3;
import 'chat_message.dart' as _i4;
import 'comment.dart' as _i5;
import 'credential.dart' as _i6;
import 'user_profile.dart' as _i7;
import 'package:carrerproj_client/src/protocol/article.dart' as _i8;
import 'package:carrerproj_client/src/protocol/article_like.dart' as _i9;
import 'package:carrerproj_client/src/protocol/chat_message.dart' as _i10;
import 'package:carrerproj_client/src/protocol/comment.dart' as _i11;
import 'package:carrerproj_client/src/protocol/credential.dart' as _i12;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i13;
export 'article.dart';
export 'article_like.dart';
export 'chat_message.dart';
export 'comment.dart';
export 'credential.dart';
export 'user_profile.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Article) {
      return _i2.Article.fromJson(data) as T;
    }
    if (t == _i3.ArticleLike) {
      return _i3.ArticleLike.fromJson(data) as T;
    }
    if (t == _i4.ChatMessage) {
      return _i4.ChatMessage.fromJson(data) as T;
    }
    if (t == _i5.Comment) {
      return _i5.Comment.fromJson(data) as T;
    }
    if (t == _i6.Credentials) {
      return _i6.Credentials.fromJson(data) as T;
    }
    if (t == _i7.UserProfile) {
      return _i7.UserProfile.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Article?>()) {
      return (data != null ? _i2.Article.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ArticleLike?>()) {
      return (data != null ? _i3.ArticleLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ChatMessage?>()) {
      return (data != null ? _i4.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Comment?>()) {
      return (data != null ? _i5.Comment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Credentials?>()) {
      return (data != null ? _i6.Credentials.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.UserProfile?>()) {
      return (data != null ? _i7.UserProfile.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList()
          as dynamic;
    }
    if (t == List<_i8.Article>) {
      return (data as List).map((e) => deserialize<_i8.Article>(e)).toList()
          as dynamic;
    }
    if (t == List<_i9.ArticleLike>) {
      return (data as List).map((e) => deserialize<_i9.ArticleLike>(e)).toList()
          as dynamic;
    }
    if (t == List<_i10.ChatMessage>) {
      return (data as List)
          .map((e) => deserialize<_i10.ChatMessage>(e))
          .toList() as dynamic;
    }
    if (t == List<_i11.Comment>) {
      return (data as List).map((e) => deserialize<_i11.Comment>(e)).toList()
          as dynamic;
    }
    if (t == List<_i12.Credentials>) {
      return (data as List)
          .map((e) => deserialize<_i12.Credentials>(e))
          .toList() as dynamic;
    }
    try {
      return _i13.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Article) {
      return 'Article';
    }
    if (data is _i3.ArticleLike) {
      return 'ArticleLike';
    }
    if (data is _i4.ChatMessage) {
      return 'ChatMessage';
    }
    if (data is _i5.Comment) {
      return 'Comment';
    }
    if (data is _i6.Credentials) {
      return 'Credentials';
    }
    if (data is _i7.UserProfile) {
      return 'UserProfile';
    }
    className = _i13.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Article') {
      return deserialize<_i2.Article>(data['data']);
    }
    if (dataClassName == 'ArticleLike') {
      return deserialize<_i3.ArticleLike>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i4.ChatMessage>(data['data']);
    }
    if (dataClassName == 'Comment') {
      return deserialize<_i5.Comment>(data['data']);
    }
    if (dataClassName == 'Credentials') {
      return deserialize<_i6.Credentials>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i7.UserProfile>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i13.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
