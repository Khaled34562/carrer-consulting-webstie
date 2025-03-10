import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Endpoint for handling user-related operations.
class UserEndpoint extends Endpoint {
  /// Retrieves a user profile by their [userId].
  ///
  /// Returns a [UserProfile] object if found, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile? user = await client.user.getUserProfile(userId);
  /// ```
  Future<UserProfile?> getUserProfile(Session session, int userId) async {
    return await UserProfile.db.findFirstRow(
      session,
      where: (u) => u.userId.equals(userId),
    );
    ;
  }

  /// Updates an existing user profile with the provided [updatedUser] object.
  ///
  /// Returns the updated [UserProfile] if successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile? result = await client.user.updateUserProfile(UserProfile: updatedUserProfile);
  /// ```
  Future<UserProfile?> updateUserProfile(
      Session session, UserProfile updatedUserProfile) async {
    // Update the user in the database
    return await UserProfile.db.updateRow(session, updatedUserProfile);
  }

  /// Creates a new user profile using the [newUser] object.
  ///
  /// Returns the created [UserProfile] if successful, otherwise `null`.
  ///
  /// Example usage:
  /// ```dart
  /// UserProfile? result = await client.user.createUserProfile(UserProfile: newUserProfile);
  /// ```
  Future<UserProfile?> createUserProfile(
      Session session, UserProfile newUserProfile) async {
    return await UserProfile.db.insertRow(session, newUserProfile);
  }
}
