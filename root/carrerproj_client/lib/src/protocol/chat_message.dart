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

abstract class ChatMessage implements _i1.SerializableModel {
  ChatMessage._({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.sentAt,
    required this.isRead,
  });

  factory ChatMessage({
    int? id,
    required int senderId,
    required int receiverId,
    required String text,
    required DateTime sentAt,
    required bool isRead,
  }) = _ChatMessageImpl;

  factory ChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatMessage(
      id: jsonSerialization['id'] as int?,
      senderId: jsonSerialization['senderId'] as int,
      receiverId: jsonSerialization['receiverId'] as int,
      text: jsonSerialization['text'] as String,
      sentAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      isRead: jsonSerialization['isRead'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int senderId;

  int receiverId;

  String text;

  DateTime sentAt;

  bool isRead;

  ChatMessage copyWith({
    int? id,
    int? senderId,
    int? receiverId,
    String? text,
    DateTime? sentAt,
    bool? isRead,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'sentAt': sentAt.toJson(),
      'isRead': isRead,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatMessageImpl extends ChatMessage {
  _ChatMessageImpl({
    int? id,
    required int senderId,
    required int receiverId,
    required String text,
    required DateTime sentAt,
    required bool isRead,
  }) : super._(
          id: id,
          senderId: senderId,
          receiverId: receiverId,
          text: text,
          sentAt: sentAt,
          isRead: isRead,
        );

  @override
  ChatMessage copyWith({
    Object? id = _Undefined,
    int? senderId,
    int? receiverId,
    String? text,
    DateTime? sentAt,
    bool? isRead,
  }) {
    return ChatMessage(
      id: id is int? ? id : this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
      sentAt: sentAt ?? this.sentAt,
      isRead: isRead ?? this.isRead,
    );
  }
}
