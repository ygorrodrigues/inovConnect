// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:inov_connect/screens/bottom/bottom_template.dart';
import 'package:inov_connect/screens/posts/descpost.dart';
import 'package:inov_connect/screens/posts/form.dart';
import 'package:inov_connect/screens/users/forgot.dart';
import 'package:inov_connect/screens/users/signin.dart';

void main() => runApp(InovConnect());

class InovConnect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: DescPost(),
    );
  }
}