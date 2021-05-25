import 'package:doc_guard/models/user.dart';
import 'package:doc_guard/screens/authen/authenticate.dart';
import 'package:doc_guard/screens/authen/login.dart';
import 'package:doc_guard/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
