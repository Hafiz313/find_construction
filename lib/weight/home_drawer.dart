import 'package:find_construction/screens/favorite_screen.dart';
import 'package:find_construction/screens/login_screen.dart';
import 'package:find_construction/screens/profile_screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key key,
  }) : super(key: key);

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
                      'Mr Johen brithed',
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

              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
          ListTile(
            title: Text('Help center', style: TextStyle(fontSize: 15),),
            leading: Icon(FontAwesomeIcons.questionCircle,
              color: kBlueText,

            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Tall a Friend', style: TextStyle(fontSize: 15),),
            leading: Icon(FontAwesomeIcons.shareAlt,
              color: kBlueText,

            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Logout', style: TextStyle(fontSize: 15),),
            leading: Icon(FontAwesomeIcons.signOutAlt,
              color: kBlueText,

            ),
            onTap: () {},
          ),

        ],
      ),
    );
  }
}
