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

abstract class AdviceSeeker implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = AdviceSeekerTable();

  static const db = AdviceSeekerRepository._();

  @override
  int? id;

  int userId;

  String imagePath;

  String careerLevel;

  String educationBackground;

  String jobInterest;

  String resumeLink;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static AdviceSeekerInclude include() {
    return AdviceSeekerInclude._();
  }

  static AdviceSeekerIncludeList includeList({
    _i1.WhereExpressionBuilder<AdviceSeekerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdviceSeekerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdviceSeekerTable>? orderByList,
    AdviceSeekerInclude? include,
  }) {
    return AdviceSeekerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdviceSeeker.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AdviceSeeker.t),
      include: include,
    );
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

class AdviceSeekerTable extends _i1.Table {
  AdviceSeekerTable({super.tableRelation}) : super(tableName: 'advice_seeker') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    imagePath = _i1.ColumnString(
      'imagePath',
      this,
    );
    careerLevel = _i1.ColumnString(
      'careerLevel',
      this,
    );
    educationBackground = _i1.ColumnString(
      'educationBackground',
      this,
    );
    jobInterest = _i1.ColumnString(
      'jobInterest',
      this,
    );
    resumeLink = _i1.ColumnString(
      'resumeLink',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString imagePath;

  late final _i1.ColumnString careerLevel;

  late final _i1.ColumnString educationBackground;

  late final _i1.ColumnString jobInterest;

  late final _i1.ColumnString resumeLink;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        imagePath,
        careerLevel,
        educationBackground,
        jobInterest,
        resumeLink,
      ];
}

class AdviceSeekerInclude extends _i1.IncludeObject {
  AdviceSeekerInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => AdviceSeeker.t;
}

class AdviceSeekerIncludeList extends _i1.IncludeList {
  AdviceSeekerIncludeList._({
    _i1.WhereExpressionBuilder<AdviceSeekerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdviceSeeker.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => AdviceSeeker.t;
}

class AdviceSeekerRepository {
  const AdviceSeekerRepository._();

  Future<List<AdviceSeeker>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AdviceSeekerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdviceSeekerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdviceSeekerTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<AdviceSeeker>(
      where: where?.call(AdviceSeeker.t),
      orderBy: orderBy?.call(AdviceSeeker.t),
      orderByList: orderByList?.call(AdviceSeeker.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<AdviceSeeker?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AdviceSeekerTable>? where,
    int? offset,
    _i1.OrderByBuilder<AdviceSeekerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdviceSeekerTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<AdviceSeeker>(
      where: where?.call(AdviceSeeker.t),
      orderBy: orderBy?.call(AdviceSeeker.t),
      orderByList: orderByList?.call(AdviceSeeker.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<AdviceSeeker?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<AdviceSeeker>(
      id,
      transaction: transaction,
    );
  }

  Future<List<AdviceSeeker>> insert(
    _i1.Session session,
    List<AdviceSeeker> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AdviceSeeker>(
      rows,
      transaction: transaction,
    );
  }

  Future<AdviceSeeker> insertRow(
    _i1.Session session,
    AdviceSeeker row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdviceSeeker>(
      row,
      transaction: transaction,
    );
  }

  Future<List<AdviceSeeker>> update(
    _i1.Session session,
    List<AdviceSeeker> rows, {
    _i1.ColumnSelections<AdviceSeekerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AdviceSeeker>(
      rows,
      columns: columns?.call(AdviceSeeker.t),
      transaction: transaction,
    );
  }

  Future<AdviceSeeker> updateRow(
    _i1.Session session,
    AdviceSeeker row, {
    _i1.ColumnSelections<AdviceSeekerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdviceSeeker>(
      row,
      columns: columns?.call(AdviceSeeker.t),
      transaction: transaction,
    );
  }

  Future<List<AdviceSeeker>> delete(
    _i1.Session session,
    List<AdviceSeeker> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AdviceSeeker>(
      rows,
      transaction: transaction,
    );
  }

  Future<AdviceSeeker> deleteRow(
    _i1.Session session,
    AdviceSeeker row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdviceSeeker>(
      row,
      transaction: transaction,
    );
  }

  Future<List<AdviceSeeker>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AdviceSeekerTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AdviceSeeker>(
      where: where(AdviceSeeker.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AdviceSeekerTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AdviceSeeker>(
      where: where?.call(AdviceSeeker.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
