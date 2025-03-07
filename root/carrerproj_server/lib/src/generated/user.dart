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

abstract class User implements _i1.TableRow, _i1.ProtocolSerialization {
  User._({
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

  factory User({
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
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
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

  static final t = UserTable();

  static const db = UserRepository._();

  @override
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

  @override
  _i1.Table get table => t;

  User copyWith({
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
  Map<String, dynamic> toJsonForProtocol() {
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

  static UserInclude include() {
    return UserInclude._();
  }

  static UserIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(User.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
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

  @override
  User copyWith({
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
    return User(
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

class UserTable extends _i1.Table {
  UserTable({super.tableRelation}) : super(tableName: 'user') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    role = _i1.ColumnString(
      'role',
      this,
    );
    fullName = _i1.ColumnString(
      'fullName',
      this,
    );
    nickname = _i1.ColumnString(
      'nickname',
      this,
    );
    dateOfBirth = _i1.ColumnDateTime(
      'dateOfBirth',
      this,
    );
    gender = _i1.ColumnString(
      'gender',
      this,
    );
    profileImage = _i1.ColumnString(
      'profileImage',
      this,
    );
    country = _i1.ColumnString(
      'country',
      this,
    );
    languages = _i1.ColumnSerializable(
      'languages',
      this,
    );
    timezone = _i1.ColumnString(
      'timezone',
      this,
    );
    creditCardInfo = _i1.ColumnString(
      'creditCardInfo',
      this,
    );
    educationLevel = _i1.ColumnString(
      'educationLevel',
      this,
    );
    hourlyRate = _i1.ColumnDouble(
      'hourlyRate',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString role;

  late final _i1.ColumnString fullName;

  late final _i1.ColumnString nickname;

  late final _i1.ColumnDateTime dateOfBirth;

  late final _i1.ColumnString gender;

  late final _i1.ColumnString profileImage;

  late final _i1.ColumnString country;

  late final _i1.ColumnSerializable languages;

  late final _i1.ColumnString timezone;

  late final _i1.ColumnString creditCardInfo;

  late final _i1.ColumnString educationLevel;

  late final _i1.ColumnDouble hourlyRate;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        role,
        fullName,
        nickname,
        dateOfBirth,
        gender,
        profileImage,
        country,
        languages,
        timezone,
        creditCardInfo,
        educationLevel,
        hourlyRate,
      ];
}

class UserInclude extends _i1.IncludeObject {
  UserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => User.t;
}

class UserIncludeList extends _i1.IncludeList {
  UserIncludeList._({
    _i1.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => User.t;
}

class UserRepository {
  const UserRepository._();

  Future<List<User>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<User?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<User?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<User>(
      id,
      transaction: transaction,
    );
  }

  Future<List<User>> insert(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<User>(
      rows,
      transaction: transaction,
    );
  }

  Future<User> insertRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<User>(
      row,
      transaction: transaction,
    );
  }

  Future<List<User>> update(
    _i1.Session session,
    List<User> rows, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  Future<User> updateRow(
    _i1.Session session,
    User row, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  Future<List<User>> delete(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<User>(
      rows,
      transaction: transaction,
    );
  }

  Future<User> deleteRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<User>(
      row,
      transaction: transaction,
    );
  }

  Future<List<User>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
