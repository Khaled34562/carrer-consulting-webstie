# Dart ServerPod API Documentation

## 1. Comment Endpoint (comment.dart)

Handles operations related to comments.

### Methods:

#### insertComment(Session session, Comment comment) -> Future<Comment>

Inserts a new comment into the database.

- **Parameters:**
  - `comment`: A `Comment` object with `articleId`, `userId`, and `content`.
  - `session`: The current `Session` object.
- **Returns:** The inserted `Comment` object.

#### getCommentsByArticle(Session session, int articleId) -> Future<List<Comment>>

Retrieves all comments for a specific article.

- **Parameters:**
  - `articleId`: The unique identifier of the article.
  - `session`: The current `Session` object.
- **Returns:** A list of `Comment` objects.

#### getCommentsByUser(Session session, int userId) -> Future<List<Comment>>

Retrieves all comments made by a specific user.

- **Parameters:**
  - `userId`: The unique identifier of the user.
  - `session`: The current `Session` object.
- **Returns:** A list of `Comment` objects.

#### deleteComment(Session session, Comment comment) -> Future<Comment>

Deletes a specific comment.

- **Parameters:**
  - `comment`: The `Comment` object to be deleted.
  - `session`: The current `Session` object.
- **Returns:** The deleted `Comment` object.

---

## 2. Chat Endpoint (chat.dart)

Handles direct messaging between users.

### Methods:

#### sendDirectMessage(Session session, Message message) -> Future<bool>

Sends a direct message to another user.

- **Parameters:**
  - `message`: The `Message` object containing details like sender ID, receiver ID, content, and timestamp.
  - `session`: The current `Session` object.
- **Returns:** `true` if the message is successfully broadcasted.

#### observeDirectMessages(Session session, int userId1, int userId2) -> Future<Stream<Message>>

Observes messages exchanged between two users in real-time.

- **Parameters:**
  - `userId1`: The first user's unique identifier.
  - `userId2`: The second user's unique identifier.
  - `session`: The current `Session` object.
- **Returns:** A stream of `Message` objects.

#### getDirectMessageHistory(Session session, int userId1, int userId2) -> Future<List<Message>>

Retrieves the message history between two users.

- **Parameters:**
  - `userId1`: The first user's unique identifier.
  - `userId2`: The second user's unique identifier.
  - `session`: The current `Session` object.
- **Returns:** A list of `Message` objects, sorted by `sentAt`, with a maximum of 50 messages.

#### markMessagesAsRead(Session session, int senderId, int receiverId) -> Future<void>

Marks messages as read between a sender and a receiver.

- **Parameters:**
  - `senderId`: The sender's unique identifier.
  - `receiverId`: The receiver's unique identifier.
  - `session`: The current `Session` object.
- **Returns:** Nothing (method not yet implemented).

---

**End of Documentation**
