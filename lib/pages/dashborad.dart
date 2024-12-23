import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartwatch/bluetooth/bluetooth_sdk.dart';
import 'package:smartwatch/pages/history.dart';
import 'package:smartwatch/pages/settings.dart';
import 'package:smartwatch/styles.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final bluetooth = MockBluetoothSDK();
  final user = FirebaseAuth.instance.currentUser;
  String name = '';
  String email = '';
  String heartRate = '';
  String stepsCount = '';
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      if (doc.exists) {
        final data = doc.data();
        print(data);
        setState(() {
          name = data?['name'];
          email = data?['email'];
        });

        print(name);
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.color2,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 18, 54),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => History()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.history,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Row(children: [
                        Icon(
                          Icons.person,
                          color: Styles.mainColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          name,
                          style: Styles.head2,
                        ),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Icon(Icons.email),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          email,
                          style: Styles.head2,
                        ),
                      ]),
                    ],
                  )),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Styles.color2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Image.asset(
                            'assets/images/istockphoto-1183325543-612x612.jpg',
                            fit: BoxFit.contain,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Heart Rate',
                            style: Styles.mainHead,
                          ),
                        )
                      ]),
                      StreamBuilder(
                          stream: bluetooth.getHeartRateStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              heartRate = snapshot.data.toString();

                              return Text(
                                '${snapshot.data} bpm',
                                style: Styles.head1,
                              );
                            } else {
                              return const Text('Loading...');
                            }
                          }),
                    ]),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Image.asset(
                            'assets/images/images.png',
                            fit: BoxFit.contain,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Steps Count',
                            style: Styles.mainHead,
                          ),
                        )
                      ]),
                      StreamBuilder(
                          stream: bluetooth.getStepCountStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              stepsCount = snapshot.data.toString();

                              return Text(
                                '${snapshot.data} steps',
                                style: Styles.head1,
                              );
                            } else {
                              return const Text('Loading...');
                            }
                          }),
                    ]),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.uid)
                            .collection('healthRecords')
                            .add({
                          'heart_rate': heartRate,
                          'steps': stepsCount,
                          'date': DateTime.now().toIso8601String(),
                        });
                        Fluttertoast.showToast(
                          msg: "Record saved successfully!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                      } catch (e) {
                        print('Error saving record: $e');
                        Fluttertoast.showToast(
                          msg: "Failed to save record. Try again.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    },
                    child: Text(
                      'Save to Records',
                      style: Styles.mainHead,
                    ),
                    style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                      EdgeInsets.all(10),
                    ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
