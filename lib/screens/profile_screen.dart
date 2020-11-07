import 'dart:convert';

import 'package:find_construction/models/login_models.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:find_construction/weight/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static const id = "profile_screen";


  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    getValue();

  }


 Future<void> getValue() async {

   SharedPreferences pref = await SharedPreferences.getInstance();
   Map json = jsonDecode(pref.getString('login_response'));
   var user = LoginModel.fromJson(json);
    print("-----------------------login data $user-------------------");
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        /*appBar: AppBar(
          backgroundColor: kBlueText,
          title: Center(child: Text("Profile")),
        ),*/
        drawer: HomeDrawer(),
        body: Container(
          height: 300,
          child: Column(
            children: [
            /* Container(child:
             Stack(children: <Widget>[
               Container(
                 decoration: BoxDecoration(
                   color: Colors.transparent,
                   image: DecorationImage(
                     fit: BoxFit.fill,
                     //image: AssetImage('images/bg.jpg',),
                   ),
                 ),
                 height: 300.0,
               ),
               Container(
                 height: 300.0,
                 decoration: BoxDecoration(
                     color: Colors.white,
                     gradient: LinearGradient(
                         begin: FractionalOffset.topCenter,
                         end: FractionalOffset.bottomCenter,
                         colors: [
                           //Colors.blueAccent.withOpacity(0.0),
                           Colors.blueAccent.withOpacity(0.0),
                           Colors.blueAccent
                         ],
                         stops: [
                           0.0,
                           1.0
                         ])),
               )
             ]),
             )*/
            ],
          ),
        ),
      ),
    );
  }
}
