import 'package:believableuser/screens/product_detail_page.dart';
import 'package:believableuser/screens/products_list_page.dart';
import 'package:believableuser/widgets/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InitializerWidget extends StatefulWidget {
  static final String routename = "/initial-login-page";
  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  FirebaseAuth _auth;

  Future<FirebaseUser> _user;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
