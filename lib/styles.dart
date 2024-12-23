import 'package:flutter/material.dart';

class Styles {
  static final head2 =
      TextStyle(color: const Color.fromARGB(255, 5, 15, 22), fontSize: 18);
  static final mainColor = Color.fromARGB(255, 28, 18, 54);
  static final color2 = const Color.fromARGB(255, 208, 215, 247);
  static final mainHead =
      TextStyle(color: mainColor, fontSize: 20, fontWeight: FontWeight.bold);
  static final head1 = TextStyle(color: mainColor, fontWeight: FontWeight.bold);
  static final buttonStyle = ButtonStyle(
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
}
