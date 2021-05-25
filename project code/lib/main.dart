import 'package:doc_guard/models/user.dart';
import 'package:doc_guard/screens/wrapper.dart';
import 'package:doc_guard/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()=> runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: wrapper(),
      ),
    );
  }
}


