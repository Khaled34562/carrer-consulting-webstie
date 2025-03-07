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

abstract class Comment implements _i1.SerializableModel {
  Comment._({
    this.id,
    required this.articleId,
    required this.userId,
    required this.comment,
    required this.createdAt,
  });

  factory Comment({
    int? id,
    required int articleId,
    required int userId,
    required String comment,
    required DateTime createdAt,
  }) = _CommentImpl;

  factory Comment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Comment(
      id: jsonSerialization['id'] as int?,
      articleId: jsonSerialization['articleId'] as int,
      userId: jsonSerialization['userId'] as int,
      comment: jsonSerialization['comment'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int articleId;

  int userId;

  String comment;

  DateTime createdAt;

  Comment copyWith({
    int? id,
    int? articleId,
    int? userId,
    String? comment,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'articleId': articleId,
      'userId': userId,
      'comment': comment,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentImpl extends Comment {
  _CommentImpl({
    int? id,
    required int articleId,
    required int userId,
    required String comment,
    required DateTime createdAt,
  }) : super._(
          id: id,
          articleId: articleId,
          userId: userId,
          comment: comment,
          createdAt: createdAt,
        );

  @override
  Comment copyWith({
    Object? id = _Undefined,
    int? articleId,
    int? userId,
    String? comment,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id is int? ? id : this.id,
      articleId: articleId ?? this.articleId,
      userId: userId ?? this.userId,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
