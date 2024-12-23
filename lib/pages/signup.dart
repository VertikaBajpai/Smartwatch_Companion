import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartwatch/auth.dart';
import 'package:smartwatch/pages/login.dart';
import 'package:smartwatch/styles.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.color2,
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 50),
              child: Column(children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Styles.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        'Name',
                        style: Styles.head1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter name'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Email',
                        style: Styles.head1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter email'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Password',
                        style: Styles.head1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: _isObscured,
                        controller: passwordController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
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
                    ])),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await Auth().createUser(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: "An error occurred: $e",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                        );
                        print(e);
                      }
                    },
                    child: Center(
                      child: Text('Sign Up'),
                    )),
              ])),
        ));
  }
}
