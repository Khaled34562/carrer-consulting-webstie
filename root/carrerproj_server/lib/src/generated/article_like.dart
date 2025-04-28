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

abstract class ArticleLike implements _i1.TableRow, _i1.ProtocolSerialization {
  ArticleLike._({
    this.id,
    required this.userId,
    required this.articleId,
    this.createdAt,
  });

  factory ArticleLike({
    int? id,
    required int userId,
    required int articleId,
    DateTime? createdAt,
  }) = _ArticleLikeImpl;

  factory ArticleLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArticleLike(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      articleId: jsonSerialization['articleId'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ArticleLikeTable();

  static const db = ArticleLikeRepository._();

  @override
  int? id;

  int userId;

  int articleId;

  DateTime? createdAt;

  @override
  _i1.Table get table => t;

  ArticleLike copyWith({
    int? id,
    int? userId,
    int? articleId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'articleId': articleId,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'articleId': articleId,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  static ArticleLikeInclude include() {
    return ArticleLikeInclude._();
  }

  static ArticleLikeIncludeList includeList({
    _i1.WhereExpressionBuilder<ArticleLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArticleLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArticleLikeTable>? orderByList,
    ArticleLikeInclude? include,
  }) {
    return ArticleLikeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArticleLike.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ArticleLike.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArticleLikeImpl extends ArticleLike {
  _ArticleLikeImpl({
    int? id,
    required int userId,
    required int articleId,
    DateTime? createdAt,
  }) : super._(
          id: id,
          userId: userId,
          articleId: articleId,
          createdAt: createdAt,
        );

  @override
  ArticleLike copyWith({
    Object? id = _Undefined,
    int? userId,
    int? articleId,
    Object? createdAt = _Undefined,
  }) {
    return ArticleLike(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      articleId: articleId ?? this.articleId,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}

class ArticleLikeTable extends _i1.Table {
  ArticleLikeTable({super.tableRelation}) : super(tableName: 'article_like') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    articleId = _i1.ColumnInt(
      'articleId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt articleId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        articleId,
        createdAt,
      ];
}

class ArticleLikeInclude extends _i1.IncludeObject {
  ArticleLikeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => ArticleLike.t;
}

class ArticleLikeIncludeList extends _i1.IncludeList {
  ArticleLikeIncludeList._({
    _i1.WhereExpressionBuilder<ArticleLikeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ArticleLike.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => ArticleLike.t;
}

class ArticleLikeRepository {
  const ArticleLikeRepository._();

  Future<List<ArticleLike>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ArticleLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArticleLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArticleLikeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ArticleLike>(
      where: where?.call(ArticleLike.t),
      orderBy: orderBy?.call(ArticleLike.t),
      orderByList: orderByList?.call(ArticleLike.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<ArticleLike?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ArticleLikeTable>? where,
    int? offset,
    _i1.OrderByBuilder<ArticleLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArticleLikeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ArticleLike>(
      where: where?.call(ArticleLike.t),
      orderBy: orderBy?.call(ArticleLike.t),
      orderByList: orderByList?.call(ArticleLike.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<ArticleLike?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ArticleLike>(
      id,
      transaction: transaction,
    );
  }

  Future<List<ArticleLike>> insert(
    _i1.Session session,
    List<ArticleLike> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ArticleLike>(
      rows,
      transaction: transaction,
    );
  }

  Future<ArticleLike> insertRow(
    _i1.Session session,
    ArticleLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ArticleLike>(
      row,
      transaction: transaction,
    );
  }

  Future<List<ArticleLike>> update(
    _i1.Session session,
    List<ArticleLike> rows, {
    _i1.ColumnSelections<ArticleLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ArticleLike>(
      rows,
      columns: columns?.call(ArticleLike.t),
      transaction: transaction,
    );
  }

  Future<ArticleLike> updateRow(
    _i1.Session session,
    ArticleLike row, {
    _i1.ColumnSelections<ArticleLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ArticleLike>(
      row,
      columns: columns?.call(ArticleLike.t),
      transaction: transaction,
    );
  }

  Future<List<ArticleLike>> delete(
    _i1.Session session,
    List<ArticleLike> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ArticleLike>(
      rows,
      transaction: transaction,
    );
  }

  Future<ArticleLike> deleteRow(
    _i1.Session session,
    ArticleLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ArticleLike>(
      row,
      transaction: transaction,
    );
  }

  Future<List<ArticleLike>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ArticleLikeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ArticleLike>(
      where: where(ArticleLike.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ArticleLikeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ArticleLike>(
      where: where?.call(ArticleLike.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
