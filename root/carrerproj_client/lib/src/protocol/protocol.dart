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
import 'advice_seeker.dart' as _i2;
import 'article.dart' as _i3;
import 'comment.dart' as _i4;
import 'consultant.dart' as _i5;
import 'consultation_type.dart' as _i6;
import 'example.dart' as _i7;
import 'user.dart' as _i8;
import 'package:authinticationproj_client/src/protocol/article.dart' as _i9;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i10;
export 'advice_seeker.dart';
export 'article.dart';
export 'comment.dart';
export 'consultant.dart';
export 'consultation_type.dart';
export 'example.dart';
export 'user.dart';
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
    if (t == _i2.AdviceSeeker) {
      return _i2.AdviceSeeker.fromJson(data) as T;
    }
    if (t == _i3.Article) {
      return _i3.Article.fromJson(data) as T;
    }
    if (t == _i4.Comment) {
      return _i4.Comment.fromJson(data) as T;
    }
    if (t == _i5.Consultant) {
      return _i5.Consultant.fromJson(data) as T;
    }
    if (t == _i6.ConsultationType) {
      return _i6.ConsultationType.fromJson(data) as T;
    }
    if (t == _i7.Example) {
      return _i7.Example.fromJson(data) as T;
    }
    if (t == _i8.User) {
      return _i8.User.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AdviceSeeker?>()) {
      return (data != null ? _i2.AdviceSeeker.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Article?>()) {
      return (data != null ? _i3.Article.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Comment?>()) {
      return (data != null ? _i4.Comment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Consultant?>()) {
      return (data != null ? _i5.Consultant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ConsultationType?>()) {
      return (data != null ? _i6.ConsultationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Example?>()) {
      return (data != null ? _i7.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.User?>()) {
      return (data != null ? _i8.User.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList()
          as dynamic;
    }
    if (t == List<_i9.Article>) {
      return (data as List).map((e) => deserialize<_i9.Article>(e)).toList()
          as dynamic;
    }
    try {
      return _i10.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.AdviceSeeker) {
      return 'AdviceSeeker';
    }
    if (data is _i3.Article) {
      return 'Article';
    }
    if (data is _i4.Comment) {
      return 'Comment';
    }
    if (data is _i5.Consultant) {
      return 'Consultant';
    }
    if (data is _i6.ConsultationType) {
      return 'ConsultationType';
    }
    if (data is _i7.Example) {
      return 'Example';
    }
    if (data is _i8.User) {
      return 'User';
    }
    className = _i10.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AdviceSeeker') {
      return deserialize<_i2.AdviceSeeker>(data['data']);
    }
    if (dataClassName == 'Article') {
      return deserialize<_i3.Article>(data['data']);
    }
    if (dataClassName == 'Comment') {
      return deserialize<_i4.Comment>(data['data']);
    }
    if (dataClassName == 'Consultant') {
      return deserialize<_i5.Consultant>(data['data']);
    }
    if (dataClassName == 'ConsultationType') {
      return deserialize<_i6.ConsultationType>(data['data']);
    }
    if (dataClassName == 'Example') {
      return deserialize<_i7.Example>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i8.User>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i10.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
