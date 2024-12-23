import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartwatch/firestore_database/database.dart';
import 'package:smartwatch/styles.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> healthRecords = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;

        print("User ID: ${user?.uid}");
        final healthData = (await Database().fetchHealthRecords(uid)).toList();
        // final health_data = data.docs.map((doc) {
        //   return {'id': doc.id, 'heart_rate': doc['heart_rate']};
        // }).toList();
        print(healthData);
        setState(() {
          healthRecords = healthData;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching health records: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String timeAgo(DateTime recordDate) {
    final now = DateTime.now();
    final difference = now.difference(recordDate);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour ago';
    } else {
      return '${difference.inDays} day ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.color2,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Styles.mainColor,
        title: Text('Health Records',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : healthRecords.isEmpty
              ? Center(
                  child: Text(
                    'No previous record found',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  shrinkWrap: true,
                  itemCount: healthRecords.length,
                  itemBuilder: (context, index) {
                    final record = healthRecords[index];
                    DateTime recordDate;
                    if (record['date'] is Timestamp) {
                      recordDate = (record['date'] as Timestamp).toDate();
                    } else if (record['date'] is String) {
                      recordDate = DateTime.parse(record['date']);
                    } else {
                      recordDate = DateTime.now();
                    }

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(
                                  Icons.graphic_eq,
                                  color: Styles.color2,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  timeAgo(recordDate),
                                  style: Styles.mainHead,
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Row(children: [
                                    Icon(
                                      Icons.monitor_heart,
                                      color: const Color.fromARGB(
                                          255, 142, 27, 19),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        "Heart Rate: ${record['heart_rate'] ?? 'N/A'} bpm",
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 22, 57, 13),
                                          fontSize: 16,
                                        )),
                                  ]),
                                  Row(children: [
                                    Icon(
                                      Icons.directions_walk,
                                      color:
                                          const Color.fromARGB(255, 14, 28, 39),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Steps Count: ${record['steps'] ?? 'N/A'}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: const Color.fromARGB(
                                              255, 22, 57, 13)),
                                    ),
                                  ]),
                                ],
                              ),
                            ]),
                      ),
                    );
                  },
                ),
    );
  }
}
