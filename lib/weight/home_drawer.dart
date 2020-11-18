import 'dart:convert';
import 'package:find_construction/screens/about_us_screen.dart';
import 'package:find_construction/screens/favorite_screen.dart';
import 'package:find_construction/screens/help_center_screen.dart';
import 'package:find_construction/screens/login_screen.dart';
import 'package:find_construction/screens/profile_screen.dart';
import 'package:find_construction/screens/vedio_player.dart';
import 'package:find_construction/screens/videos_show.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  String strName;
  Future<void> read() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      strName = json.decode(prefs.getString("login_response"))["response"]["name"]?? "";
    });

  }
  _textMe() async {
    // Android
    const uri = 'sms:?body=here%20link:www.google.com';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:?body=here%20link:www.google.com';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }
  @override
  void initState() {
    super.initState();
    read();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                        backgroundImage: ExactAssetImage('images/bg.png'),
                        minRadius: 90,
                        maxRadius: 150,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$strName',
                      style: TextStyle(fontSize: 20, color: kBlueText),
                    ),
                  ],
                )),
            decoration: BoxDecoration(),
          ),
          ListTile(
            title: Text('Profile', style: TextStyle(fontSize: 15),),
            leading: Icon(FontAwesomeIcons.userCircle,
              color: kBlueText,

            ),
            onTap: () {

              Navigator.pushNamed(context, ProfileScreen.id);
            },
          ),
          ListTile(
            title: Text('Favorite', style: TextStyle(fontSize: 15),),
            leading: Icon(FontAwesomeIcons.solidHeart,
              color: kBlueText,

            ),
            onTap: () {

              Navigator.pushNamed(context, FavoriteScreen.id);
            },
          ),

          ListTile(
            title: Text('About us', style: TextStyle(fontSize: 15),),
            leading: Icon(FontAwesomeIcons.exclamationCircle,
              color: kBlueText,

            ),
            onTap: () {

              Navigator.pushNamed(context, AboutUsScreen.id);
            },
          ),
          ListTile(
            title: Text('Help center', style: TextStyle(fontSize: 15),),
            leading: Icon(FontAwesomeIcons.questionCircle,
              color: kBlueText,

            ),
            onTap: () {
              Navigator.pushNamed(context, HelpCenterScreen.id);
              //Navigator.pushNamed(context, SplashScreen.id);

            },
          ),
          ListTile(
            title: Text('Tall a Friend', style: TextStyle(fontSize: 15),),
            leading: Icon(FontAwesomeIcons.shareAlt,
              color: kBlueText,

            ),
            onTap: () {
              Navigator.pushNamed(context, ChewieDemo.id);
              //_textMe();
            },
          ),
          ListTile(
            title: Text('Logout', style: TextStyle(fontSize: 15),),
            leading: Icon(FontAwesomeIcons.signOutAlt,
              color: kBlueText,

            ),
            onTap: () async {

              final pref = await SharedPreferences.getInstance();
              await pref.clear();
              _googleSignIn.signOut();
              Navigator.pushReplacementNamed(context, LoginScreen.id);

            },
          ),

        ],
      ),
    );
  }
}

/*
class HomeDrawer extends StatelessWidget {



  F


  @override
  Widget build(BuildContext context) {
    return
  }

}*/
