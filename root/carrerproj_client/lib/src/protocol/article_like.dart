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

abstract class ArticleLike implements _i1.SerializableModel {
  ArticleLike._({
    this.id,
    required this.userId,
    required this.articleId,
    this.createdAt,
  });

  factory ArticleLike({
    int? id,
    required int userId,
    required int articleId,
    DateTime? createdAt,
  }) = _ArticleLikeImpl;

  factory ArticleLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArticleLike(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      articleId: jsonSerialization['articleId'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int articleId;

  DateTime? createdAt;

  ArticleLike copyWith({
    int? id,
    int? userId,
    int? articleId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'articleId': articleId,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArticleLikeImpl extends ArticleLike {
  _ArticleLikeImpl({
    int? id,
    required int userId,
    required int articleId,
    DateTime? createdAt,
  }) : super._(
          id: id,
          userId: userId,
          articleId: articleId,
          createdAt: createdAt,
        );

  @override
  ArticleLike copyWith({
    Object? id = _Undefined,
    int? userId,
    int? articleId,
    Object? createdAt = _Undefined,
  }) {
    return ArticleLike(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      articleId: articleId ?? this.articleId,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}
