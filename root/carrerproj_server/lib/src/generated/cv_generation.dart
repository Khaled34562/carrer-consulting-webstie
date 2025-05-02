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
import 'user_profile.dart' as _i2;

abstract class CVGeneration implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = CVGenerationTable();

  static const db = CVGenerationRepository._();

  @override
  int? id;

  int cvId;

  int userId;

  _i2.UserProfile userProfileSnapshot;

  String? generatedCV;

  String? status;

  String? error;

  DateTime createdAt;

  DateTime? generatedAt;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'cvId': cvId,
      'userId': userId,
      'userProfileSnapshot': userProfileSnapshot.toJsonForProtocol(),
      if (generatedCV != null) 'generatedCV': generatedCV,
      if (status != null) 'status': status,
      if (error != null) 'error': error,
      'createdAt': createdAt.toJson(),
      if (generatedAt != null) 'generatedAt': generatedAt?.toJson(),
    };
  }

  static CVGenerationInclude include() {
    return CVGenerationInclude._();
  }

  static CVGenerationIncludeList includeList({
    _i1.WhereExpressionBuilder<CVGenerationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CVGenerationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CVGenerationTable>? orderByList,
    CVGenerationInclude? include,
  }) {
    return CVGenerationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CVGeneration.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CVGeneration.t),
      include: include,
    );
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

class CVGenerationTable extends _i1.Table {
  CVGenerationTable({super.tableRelation})
      : super(tableName: 'cv_generations') {
    cvId = _i1.ColumnInt(
      'cvId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    userProfileSnapshot = _i1.ColumnSerializable(
      'userProfileSnapshot',
      this,
    );
    generatedCV = _i1.ColumnString(
      'generatedCV',
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
    generatedAt = _i1.ColumnDateTime(
      'generatedAt',
      this,
    );
  }

  late final _i1.ColumnInt cvId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnSerializable userProfileSnapshot;

  late final _i1.ColumnString generatedCV;

  late final _i1.ColumnString status;

  late final _i1.ColumnString error;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime generatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        cvId,
        userId,
        userProfileSnapshot,
        generatedCV,
        status,
        error,
        createdAt,
        generatedAt,
      ];
}

class CVGenerationInclude extends _i1.IncludeObject {
  CVGenerationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => CVGeneration.t;
}

class CVGenerationIncludeList extends _i1.IncludeList {
  CVGenerationIncludeList._({
    _i1.WhereExpressionBuilder<CVGenerationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CVGeneration.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => CVGeneration.t;
}

class CVGenerationRepository {
  const CVGenerationRepository._();

  /// Returns a list of [CVGeneration]s matching the given query parameters.
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
  Future<List<CVGeneration>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CVGenerationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CVGenerationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CVGenerationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CVGeneration>(
      where: where?.call(CVGeneration.t),
      orderBy: orderBy?.call(CVGeneration.t),
      orderByList: orderByList?.call(CVGeneration.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CVGeneration] matching the given query parameters.
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
  Future<CVGeneration?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CVGenerationTable>? where,
    int? offset,
    _i1.OrderByBuilder<CVGenerationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CVGenerationTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CVGeneration>(
      where: where?.call(CVGeneration.t),
      orderBy: orderBy?.call(CVGeneration.t),
      orderByList: orderByList?.call(CVGeneration.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CVGeneration] by its [id] or null if no such row exists.
  Future<CVGeneration?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CVGeneration>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CVGeneration]s in the list and returns the inserted rows.
  ///
  /// The returned [CVGeneration]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CVGeneration>> insert(
    _i1.Session session,
    List<CVGeneration> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CVGeneration>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CVGeneration] and returns the inserted row.
  ///
  /// The returned [CVGeneration] will have its `id` field set.
  Future<CVGeneration> insertRow(
    _i1.Session session,
    CVGeneration row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CVGeneration>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CVGeneration]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CVGeneration>> update(
    _i1.Session session,
    List<CVGeneration> rows, {
    _i1.ColumnSelections<CVGenerationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CVGeneration>(
      rows,
      columns: columns?.call(CVGeneration.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CVGeneration]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CVGeneration> updateRow(
    _i1.Session session,
    CVGeneration row, {
    _i1.ColumnSelections<CVGenerationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CVGeneration>(
      row,
      columns: columns?.call(CVGeneration.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CVGeneration]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CVGeneration>> delete(
    _i1.Session session,
    List<CVGeneration> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CVGeneration>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CVGeneration].
  Future<CVGeneration> deleteRow(
    _i1.Session session,
    CVGeneration row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CVGeneration>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CVGeneration>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CVGenerationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CVGeneration>(
      where: where(CVGeneration.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CVGenerationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CVGeneration>(
      where: where?.call(CVGeneration.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
