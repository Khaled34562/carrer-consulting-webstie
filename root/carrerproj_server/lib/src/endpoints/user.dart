import 'package:authinticationproj_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Endpoint for handling user-related operations.
class UserEndpoint extends Endpoint {
  /// Retrieves a user profile by their [userId].
  ///
  /// Returns a [UserProfile] object if found, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile? user = await client.user.getUser(userId);
  /// ```
  Future<UserProfile?> getUser(Session session, int userId) async {
    return await UserProfile.db.findFirstRow(
      session,
      where: (u) => u.userId.equals(userId),
    );
  }

  /// Updates an existing user profile with the provided [updatedUser] object.
  ///
  /// Returns the updated [UserProfile] if successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile updatedUser = UserProfile(id: 1, name: 'New Name');
  /// UserProfile? result = await client.user.updateUser(updatedUser);
  /// ```
  Future<UserProfile?> updateUser(
      Session session, UserProfile updatedUser) async {
    // Update the user in the database
    return await UserProfile.db.updateRow(session, updatedUser);
  }

  /// Creates a new user profile using the [newUser] object.
  ///
  /// Returns the created [UserProfile] if successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile newUser = UserProfile(name: 'John Doe');
  /// UserProfile? result = await client.user.createUser(newUser);
  /// ```
  Future<UserProfile?> createUser(Session session, UserProfile newUser) async {
    return await UserProfile.db.insertRow(session, newUser);
  }
}
