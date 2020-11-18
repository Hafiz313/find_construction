import 'package:find_construction/screens/about_us_screen.dart';
import 'package:find_construction/screens/conformed_password_screen.dart';
import 'package:find_construction/screens/detail_screen.dart';
import 'package:find_construction/screens/favorite_screen.dart';
import 'package:find_construction/screens/forget_screen.dart';
import 'package:find_construction/screens/help_center_screen.dart';
import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/screens/loading_screen.dart';
import 'package:find_construction/screens/login_screen.dart';
import 'package:find_construction/screens/code_verification_screen.dart';
import 'package:find_construction/screens/profile_screen.dart';
import 'package:find_construction/screens/registration_screen.dart';
import 'package:find_construction/screens/splash_screen.dart';
import 'package:find_construction/screens/vedio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     initialRoute: SplashScreen.id,
      routes: {
        LoginScreen.id :(context) => LoginScreen(),
        SplashScreen.id:(context) => SplashScreen(),

        RegistrationScreen.id :(context) => RegistrationScreen(),
        HomeScreen.id :(context) => HomeScreen(),
        FavoriteScreen.id :(context) => FavoriteScreen(),
        DetailScreen.id :(context) => DetailScreen(),
        ForgetScreen.id :(context) => ForgetScreen(),
        CodeVerificationScreen.id:(context) => CodeVerificationScreen(),
        ConfermedPasswordScreen.id:(context) => ConfermedPasswordScreen(),
        LoadingScreen.id :(context) => LoadingScreen(),
        ProfileScreen.id :(context) => ProfileScreen(),
        AboutUsScreen.id :(context) => AboutUsScreen(),
        HelpCenterScreen.id :(context) => HelpCenterScreen(),
        ChewieDemo.id :(context) => ChewieDemo(),
      },
    );
  }
}


