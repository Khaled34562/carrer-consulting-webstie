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
import 'consultation_type.dart' as _i2;

abstract class Consultant implements _i1.SerializableModel {
  Consultant._({
    this.id,
    required this.userId,
    required this.imagePath,
    required this.availabilityStart,
    required this.availabilityEnd,
    required this.specializationField,
    required this.degree,
    required this.yearsOfExperience,
    required this.consultationType,
    required this.bio,
    required this.rating,
  });

  factory Consultant({
    int? id,
    required int userId,
    required String imagePath,
    required DateTime availabilityStart,
    required DateTime availabilityEnd,
    required String specializationField,
    required String degree,
    required int yearsOfExperience,
    required _i2.ConsultationType consultationType,
    required String bio,
    required double rating,
  }) = _ConsultantImpl;

  factory Consultant.fromJson(Map<String, dynamic> jsonSerialization) {
    return Consultant(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      imagePath: jsonSerialization['imagePath'] as String,
      availabilityStart: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['availabilityStart']),
      availabilityEnd: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['availabilityEnd']),
      specializationField: jsonSerialization['specializationField'] as String,
      degree: jsonSerialization['degree'] as String,
      yearsOfExperience: jsonSerialization['yearsOfExperience'] as int,
      consultationType: _i2.ConsultationType.fromJson(
          (jsonSerialization['consultationType'] as String)),
      bio: jsonSerialization['bio'] as String,
      rating: (jsonSerialization['rating'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String imagePath;

  DateTime availabilityStart;

  DateTime availabilityEnd;

  String specializationField;

  String degree;

  int yearsOfExperience;

  _i2.ConsultationType consultationType;

  String bio;

  double rating;

  Consultant copyWith({
    int? id,
    int? userId,
    String? imagePath,
    DateTime? availabilityStart,
    DateTime? availabilityEnd,
    String? specializationField,
    String? degree,
    int? yearsOfExperience,
    _i2.ConsultationType? consultationType,
    String? bio,
    double? rating,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'imagePath': imagePath,
      'availabilityStart': availabilityStart.toJson(),
      'availabilityEnd': availabilityEnd.toJson(),
      'specializationField': specializationField,
      'degree': degree,
      'yearsOfExperience': yearsOfExperience,
      'consultationType': consultationType.toJson(),
      'bio': bio,
      'rating': rating,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConsultantImpl extends Consultant {
  _ConsultantImpl({
    int? id,
    required int userId,
    required String imagePath,
    required DateTime availabilityStart,
    required DateTime availabilityEnd,
    required String specializationField,
    required String degree,
    required int yearsOfExperience,
    required _i2.ConsultationType consultationType,
    required String bio,
    required double rating,
  }) : super._(
          id: id,
          userId: userId,
          imagePath: imagePath,
          availabilityStart: availabilityStart,
          availabilityEnd: availabilityEnd,
          specializationField: specializationField,
          degree: degree,
          yearsOfExperience: yearsOfExperience,
          consultationType: consultationType,
          bio: bio,
          rating: rating,
        );

  @override
  Consultant copyWith({
    Object? id = _Undefined,
    int? userId,
    String? imagePath,
    DateTime? availabilityStart,
    DateTime? availabilityEnd,
    String? specializationField,
    String? degree,
    int? yearsOfExperience,
    _i2.ConsultationType? consultationType,
    String? bio,
    double? rating,
  }) {
    return Consultant(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      imagePath: imagePath ?? this.imagePath,
      availabilityStart: availabilityStart ?? this.availabilityStart,
      availabilityEnd: availabilityEnd ?? this.availabilityEnd,
      specializationField: specializationField ?? this.specializationField,
      degree: degree ?? this.degree,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      consultationType: consultationType ?? this.consultationType,
      bio: bio ?? this.bio,
      rating: rating ?? this.rating,
    );
  }
}
