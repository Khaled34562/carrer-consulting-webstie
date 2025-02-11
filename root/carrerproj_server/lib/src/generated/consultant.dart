/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'consultation_type.dart' as _i2;

abstract class Consultant implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = ConsultantTable();

  static const db = ConsultantRepository._();

  @override
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

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static ConsultantInclude include() {
    return ConsultantInclude._();
  }

  static ConsultantIncludeList includeList({
    _i1.WhereExpressionBuilder<ConsultantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConsultantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConsultantTable>? orderByList,
    ConsultantInclude? include,
  }) {
    return ConsultantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Consultant.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Consultant.t),
      include: include,
    );
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

class ConsultantTable extends _i1.Table {
  ConsultantTable({super.tableRelation}) : super(tableName: 'consultant') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    imagePath = _i1.ColumnString(
      'imagePath',
      this,
    );
    availabilityStart = _i1.ColumnDateTime(
      'availabilityStart',
      this,
    );
    availabilityEnd = _i1.ColumnDateTime(
      'availabilityEnd',
      this,
    );
    specializationField = _i1.ColumnString(
      'specializationField',
      this,
    );
    degree = _i1.ColumnString(
      'degree',
      this,
    );
    yearsOfExperience = _i1.ColumnInt(
      'yearsOfExperience',
      this,
    );
    consultationType = _i1.ColumnEnum(
      'consultationType',
      this,
      _i1.EnumSerialization.byName,
    );
    bio = _i1.ColumnString(
      'bio',
      this,
    );
    rating = _i1.ColumnDouble(
      'rating',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString imagePath;

  late final _i1.ColumnDateTime availabilityStart;

  late final _i1.ColumnDateTime availabilityEnd;

  late final _i1.ColumnString specializationField;

  late final _i1.ColumnString degree;

  late final _i1.ColumnInt yearsOfExperience;

  late final _i1.ColumnEnum<_i2.ConsultationType> consultationType;

  late final _i1.ColumnString bio;

  late final _i1.ColumnDouble rating;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        imagePath,
        availabilityStart,
        availabilityEnd,
        specializationField,
        degree,
        yearsOfExperience,
        consultationType,
        bio,
        rating,
      ];
}

class ConsultantInclude extends _i1.IncludeObject {
  ConsultantInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Consultant.t;
}

class ConsultantIncludeList extends _i1.IncludeList {
  ConsultantIncludeList._({
    _i1.WhereExpressionBuilder<ConsultantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Consultant.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Consultant.t;
}

class ConsultantRepository {
  const ConsultantRepository._();

  Future<List<Consultant>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ConsultantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConsultantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConsultantTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Consultant>(
      where: where?.call(Consultant.t),
      orderBy: orderBy?.call(Consultant.t),
      orderByList: orderByList?.call(Consultant.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Consultant?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ConsultantTable>? where,
    int? offset,
    _i1.OrderByBuilder<ConsultantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConsultantTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Consultant>(
      where: where?.call(Consultant.t),
      orderBy: orderBy?.call(Consultant.t),
      orderByList: orderByList?.call(Consultant.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Consultant?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Consultant>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Consultant>> insert(
    _i1.Session session,
    List<Consultant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Consultant>(
      rows,
      transaction: transaction,
    );
  }

  Future<Consultant> insertRow(
    _i1.Session session,
    Consultant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Consultant>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Consultant>> update(
    _i1.Session session,
    List<Consultant> rows, {
    _i1.ColumnSelections<ConsultantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Consultant>(
      rows,
      columns: columns?.call(Consultant.t),
      transaction: transaction,
    );
  }

  Future<Consultant> updateRow(
    _i1.Session session,
    Consultant row, {
    _i1.ColumnSelections<ConsultantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Consultant>(
      row,
      columns: columns?.call(Consultant.t),
      transaction: transaction,
    );
  }

  Future<List<Consultant>> delete(
    _i1.Session session,
    List<Consultant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Consultant>(
      rows,
      transaction: transaction,
    );
  }

  Future<Consultant> deleteRow(
    _i1.Session session,
    Consultant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Consultant>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Consultant>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ConsultantTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Consultant>(
      where: where(Consultant.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ConsultantTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Consultant>(
      where: where?.call(Consultant.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
