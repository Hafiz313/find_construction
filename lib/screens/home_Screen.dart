import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorite'),
          leading: IconButton(
              icon: Icon(FontAwesomeIcons.alignLeft),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
              ),
              onPressed: () {
                print("alkdfjl");
                // do something
              },
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 0,

          items: [
            BottomNavigationBarItem(
              icon:  Icon(FontAwesomeIcons.user),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.home),
              title: Text(''),
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidHeart),
              title: Text(''),

            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: Container(
            child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(100, (index) {
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
                         SizedBox(height: 10,),
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
        )));
  }
}
