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

abstract class CVReview implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = CVReviewTable();

  static const db = CVReviewRepository._();

  @override
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

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [CVReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
  Map<String, dynamic> toJsonForProtocol() {
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

  static CVReviewInclude include() {
    return CVReviewInclude._();
  }

  static CVReviewIncludeList includeList({
    _i1.WhereExpressionBuilder<CVReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CVReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CVReviewTable>? orderByList,
    CVReviewInclude? include,
  }) {
    return CVReviewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CVReview.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CVReview.t),
      include: include,
    );
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

  /// Returns a shallow copy of this [CVReview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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

class CVReviewTable extends _i1.Table {
  CVReviewTable({super.tableRelation}) : super(tableName: 'cv_reviews') {
    cvId = _i1.ColumnInt(
      'cvId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    originalCV = _i1.ColumnString(
      'originalCV',
      this,
    );
    feedback = _i1.ColumnString(
      'feedback',
      this,
    );
    targetLanguage = _i1.ColumnString(
      'targetLanguage',
      this,
    );
    targetCountry = _i1.ColumnString(
      'targetCountry',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    error = _i1.ColumnString(
      'error',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    reviewedAt = _i1.ColumnDateTime(
      'reviewedAt',
      this,
    );
  }

  late final _i1.ColumnInt cvId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString originalCV;

  late final _i1.ColumnString feedback;

  late final _i1.ColumnString targetLanguage;

  late final _i1.ColumnString targetCountry;

  late final _i1.ColumnString status;

  late final _i1.ColumnString error;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime reviewedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        cvId,
        userId,
        originalCV,
        feedback,
        targetLanguage,
        targetCountry,
        status,
        error,
        createdAt,
        reviewedAt,
      ];
}

class CVReviewInclude extends _i1.IncludeObject {
  CVReviewInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => CVReview.t;
}

class CVReviewIncludeList extends _i1.IncludeList {
  CVReviewIncludeList._({
    _i1.WhereExpressionBuilder<CVReviewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CVReview.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => CVReview.t;
}

class CVReviewRepository {
  const CVReviewRepository._();

  /// Returns a list of [CVReview]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<CVReview>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CVReviewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CVReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CVReviewTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CVReview>(
      where: where?.call(CVReview.t),
      orderBy: orderBy?.call(CVReview.t),
      orderByList: orderByList?.call(CVReview.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CVReview] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<CVReview?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CVReviewTable>? where,
    int? offset,
    _i1.OrderByBuilder<CVReviewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CVReviewTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CVReview>(
      where: where?.call(CVReview.t),
      orderBy: orderBy?.call(CVReview.t),
      orderByList: orderByList?.call(CVReview.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CVReview] by its [id] or null if no such row exists.
  Future<CVReview?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CVReview>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CVReview]s in the list and returns the inserted rows.
  ///
  /// The returned [CVReview]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CVReview>> insert(
    _i1.Session session,
    List<CVReview> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CVReview>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CVReview] and returns the inserted row.
  ///
  /// The returned [CVReview] will have its `id` field set.
  Future<CVReview> insertRow(
    _i1.Session session,
    CVReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CVReview>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CVReview]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CVReview>> update(
    _i1.Session session,
    List<CVReview> rows, {
    _i1.ColumnSelections<CVReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CVReview>(
      rows,
      columns: columns?.call(CVReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CVReview]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CVReview> updateRow(
    _i1.Session session,
    CVReview row, {
    _i1.ColumnSelections<CVReviewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CVReview>(
      row,
      columns: columns?.call(CVReview.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CVReview]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CVReview>> delete(
    _i1.Session session,
    List<CVReview> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CVReview>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CVReview].
  Future<CVReview> deleteRow(
    _i1.Session session,
    CVReview row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CVReview>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CVReview>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CVReviewTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CVReview>(
      where: where(CVReview.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CVReviewTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CVReview>(
      where: where?.call(CVReview.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
