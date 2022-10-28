import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(MaterialApp(
    theme: new ThemeData(scaffoldBackgroundColor: const Color.fromRGBO(212, 175, 55, 1)),
    home: Choices(),
  ));
}
