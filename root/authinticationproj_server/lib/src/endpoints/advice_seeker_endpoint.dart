import 'package:serverpod/serverpod.dart';
import '../protocol.dart';

class AdviceSeekerEndpoint extends Endpoint {
  
  // Create AdviceSeeker
  Future<void> createAdviceSeeker(Session session, AdviceSeeker adviceSeeker) async {
    await AdviceSeeker.insert(session, adviceSeeker);
  }

  // Read AdviceSeeker by userId
  Future<AdviceSeeker?> getAdviceSeeker(Session session, int userId) async {
    return await AdviceSeeker.findSingleRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  // Update AdviceSeeker
  Future<void> updateAdviceSeeker(Session session, AdviceSeeker adviceSeeker) async {
    await AdviceSeeker.update(session, adviceSeeker);
  }

  // Delete AdviceSeeker
  Future<void> deleteAdviceSeeker(Session session, int userId) async {
    await AdviceSeeker.deleteWhere(session, where: (t) => t.userId.equals(userId));
  }
}