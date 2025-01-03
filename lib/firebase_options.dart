// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCgiGjPx588-kGK5ZMzTYz1rz9AgEOjf8c',
    appId: '1:644624415255:web:edcaeb37ece4cb6bffba52',
    messagingSenderId: '644624415255',
    projectId: 'smartwatch-90567',
    authDomain: 'smartwatch-90567.firebaseapp.com',
    storageBucket: 'smartwatch-90567.firebasestorage.app',
    measurementId: 'G-RTJ4JXHNB1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzWdbIFhg3vTTXwTqSoHdN_IZEbhjQGCo',
    appId: '1:644624415255:android:fdd48586249225a8ffba52',
    messagingSenderId: '644624415255',
    projectId: 'smartwatch-90567',
    storageBucket: 'smartwatch-90567.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6jD-brkVm6vkuPfCCNOWLUN500ckFdRI',
    appId: '1:644624415255:ios:693b6067133b4e8fffba52',
    messagingSenderId: '644624415255',
    projectId: 'smartwatch-90567',
    storageBucket: 'smartwatch-90567.firebasestorage.app',
    iosBundleId: 'com.example.smartwatch',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6jD-brkVm6vkuPfCCNOWLUN500ckFdRI',
    appId: '1:644624415255:ios:693b6067133b4e8fffba52',
    messagingSenderId: '644624415255',
    projectId: 'smartwatch-90567',
    storageBucket: 'smartwatch-90567.firebasestorage.app',
    iosBundleId: 'com.example.smartwatch',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCgiGjPx588-kGK5ZMzTYz1rz9AgEOjf8c',
    appId: '1:644624415255:web:7e951186dea68ee9ffba52',
    messagingSenderId: '644624415255',
    projectId: 'smartwatch-90567',
    authDomain: 'smartwatch-90567.firebaseapp.com',
    storageBucket: 'smartwatch-90567.firebasestorage.app',
    measurementId: 'G-2F3M3JLJ4G',
  );
}
