import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint for handling direct message operations between users.
class ChatEndpoint extends Endpoint {
  /// Creates a unique channel name for a conversation between two users.
  ///
  /// - [userId1]: The first user's unique identifier.
  /// - [userId2]: The second user's unique identifier.
  ///
  /// Ensures consistent channel naming by sorting user IDs.
  String createChannelName(int userId1, int userId2) {
    List<int> participants = [userId1, userId2];
    participants.sort(); // Sort to ensure consistent channel naming
    return 'dm-\${participants[0]}-\${participants[1]}';
  }

  /// Sends a direct message to another user.
  ///
  /// - [session]: The current [Session] object.
  /// - [message]: The [Message] object containing details such as sender ID, receiver ID, content, and timestamp.
  ///
  /// Saves the message to the database and broadcasts it to the appropriate channel.
  /// Returns `true` if the message is successfully broadcasted.
  Future<bool> sendDirectMessage(Session session, ChatMessage message) async {
    // Save message to database
    await ChatMessage.db.insertRow(session, message);

    // Create a unique channel name for this conversation
    String channelName =
        createChannelName(message.senderId, message.receiverId);

    // Broadcast message to this specific channel
    return await session.messages.postMessage(channelName, message);
  }

  /// Observes messages exchanged between two specific users in real-time.
  ///
  /// - [session]: The current [Session] object.
  /// - [userId1]: The first user's unique identifier.
  /// - [userId2]: The second user's unique identifier.
  ///
  /// Returns a stream of [ChatMessage] objects as they are sent.
  Future<Stream<ChatMessage>> observeDirectMessages(
    Session session,
    int userId1,
    int userId2,
  ) async {
    String channelName = createChannelName(userId1, userId2);

    // Create a stream for this channel
    var stream = session.messages.createStream(channelName);

    // Convert the dynamic stream to a Message stream
    return stream.map((message) => message as ChatMessage);
  }

  /// Retrieves the message history between two users.
  ///
  /// - [session]: The current [Session] object.
  /// - [userId1]: The first user's unique identifier.
  /// - [userId2]: The second user's unique identifier.
  ///
  /// Messages are retrieved in ascending order based on `sentAt` timestamp.
  /// Returns a list of [ChatMessage] objects, with a maximum of 50 messages.
  Future<List<ChatMessage>> getDirectMessageHistory(
    Session session,
    int userId1,
    int userId2,
  ) async {
    return await ChatMessage.db.find(
      session,
      where: (t) =>
          ((t.senderId.equals(userId1) & t.receiverId.equals(userId2)) |
              (t.senderId.equals(userId2) & t.receiverId.equals(userId1))),
      orderBy: (t) => t.sentAt,
      limit: 50,
    );
  }

  /// Marks messages as read between a sender and a receiver.
  ///
  /// - [session]: The current [Session] object.
  /// - [senderId]: The sender's unique identifier.
  /// - [receiverId]: The receiver's unique identifier.
  ///
  /// **Note:** This method is currently not implemented.
  Future<void> markMessagesAsRead(
    Session session,
    int senderId,
    int receiverId,
  ) async {
    // To be implemented later
  }
}
