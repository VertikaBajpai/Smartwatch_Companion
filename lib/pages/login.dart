import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartwatch/auth.dart';
import 'package:smartwatch/pages/dashborad.dart';
import 'package:smartwatch/pages/signup.dart';
import 'package:smartwatch/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscured = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.color2,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 50),
          child: Column(
            children: [
              Text('Login',
                  style: TextStyle(
                      color: Styles.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter email',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: _isObscured,
                controller: passwordController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Enter Password'),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () async {
                      try {
                        await Auth().signIn(
                            email: emailController.text,
                            password: passwordController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      } on FirebaseAuthException catch (e) {
                        String message = e.code;
                        if (e.code == 'user-not-found') {
                          message = 'No user found for this email';
                        } else if (e.code == 'wrong-password') {
                          message = 'Incorrect password';
                        } else if (e.code == 'invalid-email') {
                          message = 'Invalid email address';
                        }

                        // Show error toast
                        Fluttertoast.showToast(
                          msg: message,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    },
                    child: Center(
                      child: Text('Sign In'),
                    )),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Do not have an account? Create account'),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
