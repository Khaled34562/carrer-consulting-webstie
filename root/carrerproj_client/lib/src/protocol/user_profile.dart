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

abstract class UserProfile implements _i1.SerializableModel {
  UserProfile._({
    this.id,
    required this.userId,
    required this.role,
    required this.fullName,
    required this.nickname,
    required this.dateOfBirth,
    required this.gender,
    this.profileImage,
    required this.country,
    required this.languages,
    required this.timezone,
    this.creditCardInfo,
    this.educationLevel,
    this.hourlyRate,
  });

  factory UserProfile({
    int? id,
    required int userId,
    required String role,
    required String fullName,
    required String nickname,
    required DateTime dateOfBirth,
    required String gender,
    String? profileImage,
    required String country,
    required List<String> languages,
    required String timezone,
    String? creditCardInfo,
    String? educationLevel,
    double? hourlyRate,
  }) = _UserProfileImpl;

  factory UserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      role: jsonSerialization['role'] as String,
      fullName: jsonSerialization['fullName'] as String,
      nickname: jsonSerialization['nickname'] as String,
      dateOfBirth:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateOfBirth']),
      gender: jsonSerialization['gender'] as String,
      profileImage: jsonSerialization['profileImage'] as String?,
      country: jsonSerialization['country'] as String,
      languages: (jsonSerialization['languages'] as List)
          .map((e) => e as String)
          .toList(),
      timezone: jsonSerialization['timezone'] as String,
      creditCardInfo: jsonSerialization['creditCardInfo'] as String?,
      educationLevel: jsonSerialization['educationLevel'] as String?,
      hourlyRate: (jsonSerialization['hourlyRate'] as num?)?.toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String role;

  String fullName;

  String nickname;

  DateTime dateOfBirth;

  String gender;

  String? profileImage;

  String country;

  List<String> languages;

  String timezone;

  String? creditCardInfo;

  String? educationLevel;

  double? hourlyRate;

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserProfile copyWith({
    int? id,
    int? userId,
    String? role,
    String? fullName,
    String? nickname,
    DateTime? dateOfBirth,
    String? gender,
    String? profileImage,
    String? country,
    List<String>? languages,
    String? timezone,
    String? creditCardInfo,
    String? educationLevel,
    double? hourlyRate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'role': role,
      'fullName': fullName,
      'nickname': nickname,
      'dateOfBirth': dateOfBirth.toJson(),
      'gender': gender,
      if (profileImage != null) 'profileImage': profileImage,
      'country': country,
      'languages': languages.toJson(),
      'timezone': timezone,
      if (creditCardInfo != null) 'creditCardInfo': creditCardInfo,
      if (educationLevel != null) 'educationLevel': educationLevel,
      if (hourlyRate != null) 'hourlyRate': hourlyRate,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserProfileImpl extends UserProfile {
  _UserProfileImpl({
    int? id,
    required int userId,
    required String role,
    required String fullName,
    required String nickname,
    required DateTime dateOfBirth,
    required String gender,
    String? profileImage,
    required String country,
    required List<String> languages,
    required String timezone,
    String? creditCardInfo,
    String? educationLevel,
    double? hourlyRate,
  }) : super._(
          id: id,
          userId: userId,
          role: role,
          fullName: fullName,
          nickname: nickname,
          dateOfBirth: dateOfBirth,
          gender: gender,
          profileImage: profileImage,
          country: country,
          languages: languages,
          timezone: timezone,
          creditCardInfo: creditCardInfo,
          educationLevel: educationLevel,
          hourlyRate: hourlyRate,
        );

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserProfile copyWith({
    Object? id = _Undefined,
    int? userId,
    String? role,
    String? fullName,
    String? nickname,
    DateTime? dateOfBirth,
    String? gender,
    Object? profileImage = _Undefined,
    String? country,
    List<String>? languages,
    String? timezone,
    Object? creditCardInfo = _Undefined,
    Object? educationLevel = _Undefined,
    Object? hourlyRate = _Undefined,
  }) {
    return UserProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      nickname: nickname ?? this.nickname,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      profileImage: profileImage is String? ? profileImage : this.profileImage,
      country: country ?? this.country,
      languages: languages ?? this.languages.map((e0) => e0).toList(),
      timezone: timezone ?? this.timezone,
      creditCardInfo:
          creditCardInfo is String? ? creditCardInfo : this.creditCardInfo,
      educationLevel:
          educationLevel is String? ? educationLevel : this.educationLevel,
      hourlyRate: hourlyRate is double? ? hourlyRate : this.hourlyRate,
    );
  }
}
