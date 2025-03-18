import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Endpoint for handling credential-related operations.
class CredentialsEndpoint extends Endpoint {
  /// Gets an upload description for a file.
  Future<String?> getUploadDescription(Session session, String path) async {
    return await session.storage.createDirectFileUploadDescription(
      storageId: 'public',
      path: path,
    );
  }

  /// Verifies that a file was uploaded successfully.
  Future<bool> verifyUpload(Session session, String path) async {
    return await session.storage.verifyDirectFileUpload(
      storageId: 'public',
      path: path,
    );
  }

  /// Creates a new credential for a user with a file.
  Future<Credentials?> createCredentialWithFile(
    Session session,
    Credentials credential,
    String filePath,
  ) async {
    // Check if the file exists
    final fileExists = await session.storage.fileExists(
      storageId: 'public',
      path: filePath,
    );

    if (!fileExists) {
      throw Exception('File not found. Please upload the file first.');
    }

    // Get the public URL for the file
    final fileUrl = await session.storage.getPublicUrl(
      storageId: 'public',
      path: filePath,
    );

    // Set the file URL and path in the credential
    credential.fileUrl = fileUrl.toString();
    credential.filePath = filePath;

    // Insert the credential into the database
    return await Credentials.db.insertRow(session, credential);
  }

  /// Creates a new credential without a file.
  Future<Credentials?> createCredential(
    Session session,
    Credentials credential,
  ) async {
    // Insert the credential into the database
    return await Credentials.db.insertRow(session, credential);
  }

  /// Retrieves all credentials for a specific user.
  Future<List<Credentials>> getCredentialsByUserId(
    Session session,
    int userId,
  ) async {
    return await Credentials.db.find(
      session,
      where: (c) => c.userId.equals(userId),
    );
  }

  /// Updates an existing credential with a new file.
  Future<Credentials?> updateCredentialWithFile(
    Session session,
    Credentials credential,
    String filePath,
  ) async {
    // Check if the file exists
    final fileExists = await session.storage.fileExists(
      storageId: 'public',
      path: filePath,
    );

    if (!fileExists) {
      throw Exception('File not found. Please upload the file first.');
    }

    // If there's an existing file, delete it
    if (credential.filePath.isNotEmpty) {
      try {
        await session.storage.deleteFile(
          storageId: 'public',
          path: credential.filePath,
        );
      } catch (e) {
        // Log the error but continue
        session.log('Failed to delete old file: ${e.toString()}');
      }
    }

    // Get the public URL for the new file
    final fileUrl = await session.storage.getPublicUrl(
      storageId: 'public',
      path: filePath,
    );

    // Update the credential with the new file URL and path
    credential.fileUrl = fileUrl.toString();
    credential.filePath = filePath;

    // Update the credential in the database
    return await Credentials.db.updateRow(session, credential);
  }

  /// Updates an existing credential without changing the file.
  Future<Credentials?> updateCredential(
    Session session,
    Credentials credential,
  ) async {
    // Update the credential in the database
    return await Credentials.db.updateRow(session, credential);
  }

  /// Deletes a credential and its associated file.
  Future<Credentials> deleteCredential(
    Session session,
    Credentials credential,
  ) async {
    // Delete the file if it exists
    if (credential.filePath.isNotEmpty) {
      try {
        await session.storage.deleteFile(
          storageId: 'public',
          path: credential.filePath,
        );
      } catch (e) {
        // Log the error but continue with deletion
        session.log('Failed to delete file: ${e.toString()}');
      }
    }

    // Delete the credential from the database
    return await Credentials.db.deleteRow(session, credential);
  }
}
