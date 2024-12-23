import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future<void> addHealthRecord(
      String userId, Map<String, dynamic> record) async {
    final healthRecordsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('healthRecords');

    await healthRecordsRef.add(record);
  }

  Future<List<Map<String, dynamic>>> fetchHealthRecords(String userId) async {
    final healthRecordsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('healthRecords');

    final querySnapshot =
        await healthRecordsRef.orderBy('date', descending: true).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
