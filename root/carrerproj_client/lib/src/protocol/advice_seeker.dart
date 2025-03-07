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

abstract class AdviceSeeker implements _i1.SerializableModel {
  AdviceSeeker._({
    this.id,
    required this.userId,
    required this.imagePath,
    required this.careerLevel,
    required this.educationBackground,
    required this.jobInterest,
    required this.resumeLink,
  });

  factory AdviceSeeker({
    int? id,
    required int userId,
    required String imagePath,
    required String careerLevel,
    required String educationBackground,
    required String jobInterest,
    required String resumeLink,
  }) = _AdviceSeekerImpl;

  factory AdviceSeeker.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdviceSeeker(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      imagePath: jsonSerialization['imagePath'] as String,
      careerLevel: jsonSerialization['careerLevel'] as String,
      educationBackground: jsonSerialization['educationBackground'] as String,
      jobInterest: jsonSerialization['jobInterest'] as String,
      resumeLink: jsonSerialization['resumeLink'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String imagePath;

  String careerLevel;

  String educationBackground;

  String jobInterest;

  String resumeLink;

  AdviceSeeker copyWith({
    int? id,
    int? userId,
    String? imagePath,
    String? careerLevel,
    String? educationBackground,
    String? jobInterest,
    String? resumeLink,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'imagePath': imagePath,
      'careerLevel': careerLevel,
      'educationBackground': educationBackground,
      'jobInterest': jobInterest,
      'resumeLink': resumeLink,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdviceSeekerImpl extends AdviceSeeker {
  _AdviceSeekerImpl({
    int? id,
    required int userId,
    required String imagePath,
    required String careerLevel,
    required String educationBackground,
    required String jobInterest,
    required String resumeLink,
  }) : super._(
          id: id,
          userId: userId,
          imagePath: imagePath,
          careerLevel: careerLevel,
          educationBackground: educationBackground,
          jobInterest: jobInterest,
          resumeLink: resumeLink,
        );

  @override
  AdviceSeeker copyWith({
    Object? id = _Undefined,
    int? userId,
    String? imagePath,
    String? careerLevel,
    String? educationBackground,
    String? jobInterest,
    String? resumeLink,
  }) {
    return AdviceSeeker(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      imagePath: imagePath ?? this.imagePath,
      careerLevel: careerLevel ?? this.careerLevel,
      educationBackground: educationBackground ?? this.educationBackground,
      jobInterest: jobInterest ?? this.jobInterest,
      resumeLink: resumeLink ?? this.resumeLink,
    );
  }
}
