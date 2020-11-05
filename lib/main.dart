import 'package:find_construction/screens/detail_screen.dart';
import 'package:find_construction/screens/favorite_screen.dart';
import 'package:find_construction/screens/forget_screen.dart';
import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/screens/loading_screen.dart';
import 'package:find_construction/screens/login_screen.dart';
import 'package:find_construction/screens/registration_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     initialRoute: LoginScreen.id,
      //initialRoute: LoadingScreen.id,
      routes: {
        LoginScreen.id :(context) => LoginScreen(),
        RegistrationScreen.id :(context) => RegistrationScreen(),
        HomeScreen.id :(context) => HomeScreen(),
        FavoriteScreen.id :(context) => FavoriteScreen(),
        DetailScreen.id :(context) => DetailScreen(),
        ForgetScreen.id :(context) => ForgetScreen(),
        LoadingScreen.id :(context) => LoadingScreen(),
      },
    );
  }
}

