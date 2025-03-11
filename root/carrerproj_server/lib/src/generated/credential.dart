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

abstract class Credentials implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = CredentialsTable();

  static const db = CredentialsRepository._();

  @override
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

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static CredentialsInclude include() {
    return CredentialsInclude._();
  }

  static CredentialsIncludeList includeList({
    _i1.WhereExpressionBuilder<CredentialsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CredentialsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CredentialsTable>? orderByList,
    CredentialsInclude? include,
  }) {
    return CredentialsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Credentials.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Credentials.t),
      include: include,
    );
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

class CredentialsTable extends _i1.Table {
  CredentialsTable({super.tableRelation}) : super(tableName: 'credentials') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
    version = _i1.ColumnString(
      'version',
      this,
    );
    fileUrl = _i1.ColumnString(
      'fileUrl',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    issuer = _i1.ColumnString(
      'issuer',
      this,
    );
    expirationDate = _i1.ColumnDateTime(
      'expirationDate',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString name;

  late final _i1.ColumnDateTime date;

  late final _i1.ColumnString version;

  late final _i1.ColumnString fileUrl;

  late final _i1.ColumnString description;

  late final _i1.ColumnString issuer;

  late final _i1.ColumnDateTime expirationDate;

  late final _i1.ColumnString status;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        name,
        date,
        version,
        fileUrl,
        description,
        issuer,
        expirationDate,
        status,
      ];
}

class CredentialsInclude extends _i1.IncludeObject {
  CredentialsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Credentials.t;
}

class CredentialsIncludeList extends _i1.IncludeList {
  CredentialsIncludeList._({
    _i1.WhereExpressionBuilder<CredentialsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Credentials.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Credentials.t;
}

class CredentialsRepository {
  const CredentialsRepository._();

  Future<List<Credentials>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CredentialsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CredentialsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CredentialsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Credentials>(
      where: where?.call(Credentials.t),
      orderBy: orderBy?.call(Credentials.t),
      orderByList: orderByList?.call(Credentials.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Credentials?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CredentialsTable>? where,
    int? offset,
    _i1.OrderByBuilder<CredentialsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CredentialsTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Credentials>(
      where: where?.call(Credentials.t),
      orderBy: orderBy?.call(Credentials.t),
      orderByList: orderByList?.call(Credentials.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Credentials?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Credentials>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Credentials>> insert(
    _i1.Session session,
    List<Credentials> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Credentials>(
      rows,
      transaction: transaction,
    );
  }

  Future<Credentials> insertRow(
    _i1.Session session,
    Credentials row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Credentials>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Credentials>> update(
    _i1.Session session,
    List<Credentials> rows, {
    _i1.ColumnSelections<CredentialsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Credentials>(
      rows,
      columns: columns?.call(Credentials.t),
      transaction: transaction,
    );
  }

  Future<Credentials> updateRow(
    _i1.Session session,
    Credentials row, {
    _i1.ColumnSelections<CredentialsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Credentials>(
      row,
      columns: columns?.call(Credentials.t),
      transaction: transaction,
    );
  }

  Future<List<Credentials>> delete(
    _i1.Session session,
    List<Credentials> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Credentials>(
      rows,
      transaction: transaction,
    );
  }

  Future<Credentials> deleteRow(
    _i1.Session session,
    Credentials row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Credentials>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Credentials>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CredentialsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Credentials>(
      where: where(Credentials.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CredentialsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Credentials>(
      where: where?.call(Credentials.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
