import 'package:serverpod/serverpod.dart';
import '../protocol.dart';

class ConsultantEndpoint extends Endpoint {
  
  // Create Consultant
  Future<void> createConsultant(Session session, Consultant consultant) async {
    await Consultant.insert(session, consultant);
  }

  // Read Consultant by userId
  Future<Consultant?> getConsultant(Session session, int userId) async {
    return await Consultant.findSingleRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  // Update Consultant
  Future<void> updateConsultant(Session session, Consultant consultant) async {
    await Consultant.update(session, consultant);
  }

  // Delete Consultant
  Future<void> deleteConsultant(Session session, int userId) async {
    await Consultant.deleteWhere(session, where: (t) => t.userId.equals(userId));
  }
}
