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
import 'user_profile.dart' as _i2;

abstract class CVGeneration implements _i1.SerializableModel {
  CVGeneration._({
    this.id,
    required this.cvId,
    required this.userId,
    required this.userProfileSnapshot,
    this.generatedCV,
    this.status,
    this.error,
    required this.createdAt,
    this.generatedAt,
  });

  factory CVGeneration({
    int? id,
    required int cvId,
    required int userId,
    required _i2.UserProfile userProfileSnapshot,
    String? generatedCV,
    String? status,
    String? error,
    required DateTime createdAt,
    DateTime? generatedAt,
  }) = _CVGenerationImpl;

  factory CVGeneration.fromJson(Map<String, dynamic> jsonSerialization) {
    return CVGeneration(
      id: jsonSerialization['id'] as int?,
      cvId: jsonSerialization['cvId'] as int,
      userId: jsonSerialization['userId'] as int,
      userProfileSnapshot: _i2.UserProfile.fromJson(
          (jsonSerialization['userProfileSnapshot'] as Map<String, dynamic>)),
      generatedCV: jsonSerialization['generatedCV'] as String?,
      status: jsonSerialization['status'] as String?,
      error: jsonSerialization['error'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      generatedAt: jsonSerialization['generatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['generatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int cvId;

  int userId;

  _i2.UserProfile userProfileSnapshot;

  String? generatedCV;

  String? status;

  String? error;

  DateTime createdAt;

  DateTime? generatedAt;

  /// Returns a shallow copy of this [CVGeneration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CVGeneration copyWith({
    int? id,
    int? cvId,
    int? userId,
    _i2.UserProfile? userProfileSnapshot,
    String? generatedCV,
    String? status,
    String? error,
    DateTime? createdAt,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'cvId': cvId,
      'userId': userId,
      'userProfileSnapshot': userProfileSnapshot.toJson(),
      if (generatedCV != null) 'generatedCV': generatedCV,
      if (status != null) 'status': status,
      if (error != null) 'error': error,
      'createdAt': createdAt.toJson(),
      if (generatedAt != null) 'generatedAt': generatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CVGenerationImpl extends CVGeneration {
  _CVGenerationImpl({
    int? id,
    required int cvId,
    required int userId,
    required _i2.UserProfile userProfileSnapshot,
    String? generatedCV,
    String? status,
    String? error,
    required DateTime createdAt,
    DateTime? generatedAt,
  }) : super._(
          id: id,
          cvId: cvId,
          userId: userId,
          userProfileSnapshot: userProfileSnapshot,
          generatedCV: generatedCV,
          status: status,
          error: error,
          createdAt: createdAt,
          generatedAt: generatedAt,
        );

  /// Returns a shallow copy of this [CVGeneration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CVGeneration copyWith({
    Object? id = _Undefined,
    int? cvId,
    int? userId,
    _i2.UserProfile? userProfileSnapshot,
    Object? generatedCV = _Undefined,
    Object? status = _Undefined,
    Object? error = _Undefined,
    DateTime? createdAt,
    Object? generatedAt = _Undefined,
  }) {
    return CVGeneration(
      id: id is int? ? id : this.id,
      cvId: cvId ?? this.cvId,
      userId: userId ?? this.userId,
      userProfileSnapshot:
          userProfileSnapshot ?? this.userProfileSnapshot.copyWith(),
      generatedCV: generatedCV is String? ? generatedCV : this.generatedCV,
      status: status is String? ? status : this.status,
      error: error is String? ? error : this.error,
      createdAt: createdAt ?? this.createdAt,
      generatedAt: generatedAt is DateTime? ? generatedAt : this.generatedAt,
    );
  }
}
