import 'package:serverpod/serverpod.dart';
import '../generated/user.dart';

/// The `UserEndpoint` class provides endpoints for managing user-related operations.
/// This includes fetching user details, updating user information, and creating new users.
class UserEndpoint extends Endpoint {
  /// Fetches a user by their unique `userId`.
  ///
  /// Parameters:
  /// - `session`: The current server session.
  /// - `userId`: The unique identifier of the user to fetch.
  ///
  /// Returns:
  /// - A `User` object if the user is found.
  /// - `null` if no user is found with the provided `userId`.
  ///
  /// Example:
  /// ```dart
  /// final user = await user.getUser(session, 123);
  /// ```
  Future<User?> getUser(Session session, int userId) async {
    return await User.db.findFirstRow(
      session,
      where: (u) => u.userId.equals(userId),
    );
  }

  /// Updates an existing user's information in the database.
  ///
  /// Parameters:
  /// - `session`: The current server session.
  /// - `newUser`: A `User` object containing the updated user information.
  ///
  /// Returns:
  /// - The updated `User` object if the update is successful.
  /// - `null` if the user does not exist or the update fails.
  ///
  /// Example:
  /// ```dart
  /// final updatedUser = await user.updateUser(session, user);
  /// ```
  Future<User?> updateUser(Session session, User newUser) async {
    // Update the user in the database
    var updatedUser = await User.db.updateRow(session, newUser);
    return updatedUser;
  }

  /// Creates a new user in the database.
  ///
  /// Parameters:
  /// - `session`: The current server session.
  /// - `newUser`: A `User` object containing the details of the new user.
  ///
  /// Returns:
  /// - The newly created `User` object if the insertion is successful.
  /// - `null` if the insertion fails.
  ///
  /// Example:
  /// ```dart
  /// final createdUser = await user.createUser(session, user);
  /// ```
  Future<User?> createUser(Session session, User newUser) async {
    return await User.db.insertRow(session, newUser);
  }
}
