import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:find_construction/weight/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavoriteScreen extends StatefulWidget {
  static const id = "favorite_screen";

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _curIndex = 0;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorite'),
    /*      leading: IconButton(
              icon: Icon(FontAwesomeIcons.alignLeft),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),*/
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
              ),
              onPressed: () {
                print("Search Icon");
                // do something
              },
            )
          ],
        ),
        drawer: HomeDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _curIndex,
            onTap: (index){
              setState(() {
                _curIndex = index;
                switch (_curIndex) {
                  case 0:
                    break;
                  case 1:
                    Navigator.pushNamed(context, HomeScreen.id);
                    break;
                  case 2:
                    Navigator.pushNamed(context, FavoriteScreen.id);
                    break;
                }
              });
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.userAlt),
               //   icon: Icon(FontAwesomeIcons.userAlt),
                  title: Text('')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Notifications'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidHeart),
                title: Text('Notifications'),

              ),
            ]

        ),
        body: Container(
          padding: EdgeInsets.only(top: 10,bottom: 10),
            child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(10, (index) {
            return Card(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
              elevation: 5
              ,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15.0),
                        topRight: const Radius.circular(15.0),
                      ),
                      image: DecorationImage(
                        image: AssetImage("images/bg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                      child: Container(
                        alignment: Alignment.topRight,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            FontAwesomeIcons.solidHeart,
                            color: kBlueText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(

                      padding: EdgeInsets.all(10),
                     child: Column(
                       children: [
                         Container(
                           alignment: Alignment.topLeft,
                           child: Text('Modern day house',
                             style: TextStyle(color: kGry),
                           ),
                         ),
                         SizedBox(height: 7,),
                         Row(
                           children: [
                             Icon(FontAwesomeIcons.mapMarkerAlt,
                               size: 12,
                             ),
                             SizedBox(width: 5,),
                             Text('Montacute TA15 6XP, ….',
                             style: TextStyle(fontSize: 12),)
                           ],
                         )
                       ],
                     ),
                    ),
                  ),

                ],
              ),
            );
          }),
        )
        )
    );

  }

}

