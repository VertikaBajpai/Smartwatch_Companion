// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:smartwatch/styles.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   BluetoothState state = BluetoothState.UNKNOWN;
//   BluetoothDevice? device;
//   bool connect = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkBluetoothState();
//   }

//   Future<void> _checkBluetoothState() async {
//     state = await FlutterBluetoothSerial.instance.state;
//     setState(() {});
//   }

//   Future<void> _toggleBluetoothConnection() async {
//     if (connect) {
//       await FlutterBluetoothSerial.instance.disconnect();
//       setState(() {
//         connect = false;
//         device = null;
//       });
//     } else {
//       // Scan for devices and connect to the first one (simplified approach)
//       FlutterBluetoothSerial.instance.getBondedDevices().then((devices) {
//         if (devices.isNotEmpty) {
//           FlutterBluetoothSerial.instance
//               .connect(devices[0])
//               .then((connection) {
//             setState(() {
//               connect = true;
//               device = devices[0];
//             });
//           });
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Styles.color2,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: Styles.mainColor,
//         title: Text(
//           'Settings',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Column(
//         children: [
//           ListTile(
//             title: connect ? Text('DisConnect') : Text('Connect'),
//             trailing: IconButton(
//               icon: Icon(connect ? Icons.bluetooth_connected : Icons.bluetooth),
//               onPressed: _toggleBluetoothConnection,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
