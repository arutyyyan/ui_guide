import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;
  @override
  Widget build(BuildContext context) {
    if(_user == null)
      return LoginScreen();
    return Container(); // temporary place holder for Homepage
  }
}
