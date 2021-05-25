import 'package:doc_guard/screens/authen/login.dart';
import 'package:doc_guard/screens/authen/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginPage(toggleView:  toggleView);
    } else {
      return Register(toggleView:  toggleView);
    }
  }
}