import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Endpoint for handling credential-related operations.
class CredentialsEndpoint extends Endpoint {
  /// Creates a new credential for a user.
  Future<Credentials?> createCredential(
    Session session,
    Credentials credential,
  ) async {
    // Insert the credential into the database
    return await Credentials.db.insertRow(session, credential);
  }

  /// Retrieves all credentials for a specific user.
  Future<List<Credentials>> getCredentialsByUserId(
      Session session, int userId) async {
    return await Credentials.db.find(
      session,
      where: (c) => c.userId.equals(userId),
    );
  }

  /// Updates an existing credential.
  Future<Credentials?> updateCredential(
    Session session,
    Credentials credential,
  ) async {
    // Update the credential in the database
    return await Credentials.db.updateRow(session, credential);
  }

  /// Deletes a credential.
  Future<Credentials> deleteCredential(Session session, Credentials credential) async {
    return await Credentials.db.deleteRow(session, credential);
  }
}
