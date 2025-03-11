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

abstract class Credentials implements _i1.SerializableModel {
  Credentials._({
    this.id,
    required this.userId,
    required this.name,
    required this.date,
    required this.version,
    required this.fileUrl,
    this.description,
    this.issuer,
    this.expirationDate,
    this.status,
  });

  factory Credentials({
    int? id,
    required int userId,
    required String name,
    required DateTime date,
    required String version,
    required String fileUrl,
    String? description,
    String? issuer,
    DateTime? expirationDate,
    String? status,
  }) = _CredentialsImpl;

  factory Credentials.fromJson(Map<String, dynamic> jsonSerialization) {
    return Credentials(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      version: jsonSerialization['version'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      description: jsonSerialization['description'] as String?,
      issuer: jsonSerialization['issuer'] as String?,
      expirationDate: jsonSerialization['expirationDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['expirationDate']),
      status: jsonSerialization['status'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String name;

  DateTime date;

  String version;

  String fileUrl;

  String? description;

  String? issuer;

  DateTime? expirationDate;

  String? status;

  Credentials copyWith({
    int? id,
    int? userId,
    String? name,
    DateTime? date,
    String? version,
    String? fileUrl,
    String? description,
    String? issuer,
    DateTime? expirationDate,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'date': date.toJson(),
      'version': version,
      'fileUrl': fileUrl,
      if (description != null) 'description': description,
      if (issuer != null) 'issuer': issuer,
      if (expirationDate != null) 'expirationDate': expirationDate?.toJson(),
      if (status != null) 'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CredentialsImpl extends Credentials {
  _CredentialsImpl({
    int? id,
    required int userId,
    required String name,
    required DateTime date,
    required String version,
    required String fileUrl,
    String? description,
    String? issuer,
    DateTime? expirationDate,
    String? status,
  }) : super._(
          id: id,
          userId: userId,
          name: name,
          date: date,
          version: version,
          fileUrl: fileUrl,
          description: description,
          issuer: issuer,
          expirationDate: expirationDate,
          status: status,
        );

  @override
  Credentials copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
    DateTime? date,
    String? version,
    String? fileUrl,
    Object? description = _Undefined,
    Object? issuer = _Undefined,
    Object? expirationDate = _Undefined,
    Object? status = _Undefined,
  }) {
    return Credentials(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      date: date ?? this.date,
      version: version ?? this.version,
      fileUrl: fileUrl ?? this.fileUrl,
      description: description is String? ? description : this.description,
      issuer: issuer is String? ? issuer : this.issuer,
      expirationDate:
          expirationDate is DateTime? ? expirationDate : this.expirationDate,
      status: status is String? ? status : this.status,
    );
  }
}
