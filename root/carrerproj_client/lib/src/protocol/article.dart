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

abstract class Article implements _i1.SerializableModel {
  Article._({
    this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.createdAt,
    this.updatedAt,
    required this.likes,
    required this.shares,
    required this.isArchived,
  });

  factory Article({
    int? id,
    required String title,
    required String content,
    required int authorId,
    required DateTime createdAt,
    DateTime? updatedAt,
    required int likes,
    required int shares,
    required bool isArchived,
  }) = _ArticleImpl;

  factory Article.fromJson(Map<String, dynamic> jsonSerialization) {
    return Article(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      content: jsonSerialization['content'] as String,
      authorId: jsonSerialization['authorId'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      likes: jsonSerialization['likes'] as int,
      shares: jsonSerialization['shares'] as int,
      isArchived: jsonSerialization['isArchived'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String content;

  int authorId;

  DateTime createdAt;

  DateTime? updatedAt;

  int likes;

  int shares;

  bool isArchived;

  Article copyWith({
    int? id,
    String? title,
    String? content,
    int? authorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likes,
    int? shares,
    bool? isArchived,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'authorId': authorId,
      'createdAt': createdAt.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      'likes': likes,
      'shares': shares,
      'isArchived': isArchived,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArticleImpl extends Article {
  _ArticleImpl({
    int? id,
    required String title,
    required String content,
    required int authorId,
    required DateTime createdAt,
    DateTime? updatedAt,
    required int likes,
    required int shares,
    required bool isArchived,
  }) : super._(
          id: id,
          title: title,
          content: content,
          authorId: authorId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          likes: likes,
          shares: shares,
          isArchived: isArchived,
        );

  @override
  Article copyWith({
    Object? id = _Undefined,
    String? title,
    String? content,
    int? authorId,
    DateTime? createdAt,
    Object? updatedAt = _Undefined,
    int? likes,
    int? shares,
    bool? isArchived,
  }) {
    return Article(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      likes: likes ?? this.likes,
      shares: shares ?? this.shares,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}
