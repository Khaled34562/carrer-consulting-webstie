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

abstract class CVReview implements _i1.SerializableModel {
  CVReview._({
    this.id,
    required this.cvId,
    required this.userId,
    required this.originalCV,
    this.feedback,
    this.targetLanguage,
    this.targetCountry,
    this.status,
    this.error,
    required this.createdAt,
    this.reviewedAt,
  });

  factory CVReview({
    int? id,
    required int cvId,
    required int userId,
    required String originalCV,
    String? feedback,
    String? targetLanguage,
    String? targetCountry,
    String? status,
    String? error,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) = _CVReviewImpl;

  factory CVReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return CVReview(
      id: jsonSerialization['id'] as int?,
      cvId: jsonSerialization['cvId'] as int,
      userId: jsonSerialization['userId'] as int,
      originalCV: jsonSerialization['originalCV'] as String,
      feedback: jsonSerialization['feedback'] as String?,
      targetLanguage: jsonSerialization['targetLanguage'] as String?,
      targetCountry: jsonSerialization['targetCountry'] as String?,
      status: jsonSerialization['status'] as String?,
      error: jsonSerialization['error'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int cvId;

  int userId;

  String originalCV;

  String? feedback;

  String? targetLanguage;

  String? targetCountry;

  String? status;

  String? error;

  DateTime createdAt;

  DateTime? reviewedAt;

  CVReview copyWith({
    int? id,
    int? cvId,
    int? userId,
    String? originalCV,
    String? feedback,
    String? targetLanguage,
    String? targetCountry,
    String? status,
    String? error,
    DateTime? createdAt,
    DateTime? reviewedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'cvId': cvId,
      'userId': userId,
      'originalCV': originalCV,
      if (feedback != null) 'feedback': feedback,
      if (targetLanguage != null) 'targetLanguage': targetLanguage,
      if (targetCountry != null) 'targetCountry': targetCountry,
      if (status != null) 'status': status,
      if (error != null) 'error': error,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CVReviewImpl extends CVReview {
  _CVReviewImpl({
    int? id,
    required int cvId,
    required int userId,
    required String originalCV,
    String? feedback,
    String? targetLanguage,
    String? targetCountry,
    String? status,
    String? error,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) : super._(
          id: id,
          cvId: cvId,
          userId: userId,
          originalCV: originalCV,
          feedback: feedback,
          targetLanguage: targetLanguage,
          targetCountry: targetCountry,
          status: status,
          error: error,
          createdAt: createdAt,
          reviewedAt: reviewedAt,
        );

  @override
  CVReview copyWith({
    Object? id = _Undefined,
    int? cvId,
    int? userId,
    String? originalCV,
    Object? feedback = _Undefined,
    Object? targetLanguage = _Undefined,
    Object? targetCountry = _Undefined,
    Object? status = _Undefined,
    Object? error = _Undefined,
    DateTime? createdAt,
    Object? reviewedAt = _Undefined,
  }) {
    return CVReview(
      id: id is int? ? id : this.id,
      cvId: cvId ?? this.cvId,
      userId: userId ?? this.userId,
      originalCV: originalCV ?? this.originalCV,
      feedback: feedback is String? ? feedback : this.feedback,
      targetLanguage:
          targetLanguage is String? ? targetLanguage : this.targetLanguage,
      targetCountry:
          targetCountry is String? ? targetCountry : this.targetCountry,
      status: status is String? ? status : this.status,
      error: error is String? ? error : this.error,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
    );
  }
}
