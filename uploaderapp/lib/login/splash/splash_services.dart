import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uploaderapp/home_screen.dart';
import 'package:uploaderapp/login/Login_with%20_phone.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePage())));
    } else {
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginWithPhone()));
    }
  }
}
