import 'dart:async';

import 'package:find_construction/screens/code_verification_screen.dart';
import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/screens/login_screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  static const id = "splash_screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences sharedPreferences;
  String _testValue;
   bool isLogin= false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // checkLogin();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;_testValue = sharedPreferences.getString("login_response");
      if (_testValue == null)
        setState(() {
          isLogin = true;
        });

    });
    countDownTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Construction",style: TextStyle(fontSize: 25,color:kBlueText ),),
      ),
    );
  }
  countDownTime() async {
    return Timer(
      Duration(seconds: 2),
          () async {
        if(isLogin)
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        else
          Navigator.pushReplacementNamed(context, HomeScreen.id);
      },
    );
  }
}
