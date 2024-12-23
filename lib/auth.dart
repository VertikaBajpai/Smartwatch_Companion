import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  Future<void> createUser(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String userid = userCred.user!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .set({'name': name, 'email': email});
      Fluttertoast.showToast(
        msg: "User created successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      String message = e.code;
      if (e.code == 'email-already-in-use') {
        message = 'Account already exists';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      }

      // Show error toast
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      print(message);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String message = e.code;
      if (e.code == 'email-already-in-use') {
        message = 'Account already exists';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      }

      // Show error toast
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      print(message);
    }
  }
}
