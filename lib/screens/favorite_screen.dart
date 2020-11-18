import 'dart:convert';

import 'package:find_construction/models/favorite_models.dart' as favorite;
import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/screens/loading_screen.dart';
import 'package:find_construction/screens/profile_screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:find_construction/weight/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  static const id = "favorite_screen";

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isLoading=true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _curIndex = 0;
  favorite.FavoriteModel _favoriteModel;

  Future<favorite.FavoriteModel> getFavoriteHome(String userId) async {
    final String apiUrl = "https://construction.bazaaaar.com/favorite.php";
    final response = await http.post(apiUrl, body: {"uid": userId, "get": ""});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(
          "-----------favorite response : ${response.body}--------------------");
      setState(() {
        _favoriteModel = favorite.favoriteModelFromJson(responseString);
        isLoading=false;

      });

      return favorite.favoriteModelFromJson(responseString);
    } else {
      setState(() {
        isLoading=false;
      });
      return null;
    }
  }
  Future<void> readID() async {
    String userId;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
     userId= json.decode(prefs.getString("login_response"))["response"]["id"]?? "";
    });
    print("---------------------user id in favorite $userId-------------------------");

    getFavoriteHome(userId);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readID();

  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Container(
      color: Colors.white,
      child: Center(
        child: SpinKitDualRing(
          color:kBlueText,
          size: 50.0,
        ),
      ),
    ):  Scaffold(
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
            onTap: (index) {
              setState(() {
                _curIndex = index;
                switch (_curIndex) {
                  case 0:
                    // Navigator.pushReplacementNamed(context, ProfileScreen.id);
                    break;
                  case 1:
                    Navigator.pushReplacementNamed(context,HomeScreen.id);
                    break;
                  case 2:
                    Navigator.pushNamed(context, ProfileScreen.id);
                    break;
                }
              });
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.solidHeart),

                  //   icon: Icon(FontAwesomeIcons.userAlt),
                  title: Text('')),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Notifications'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.userAlt),
                title: Text('Notifications'),
              ),
            ]),
        body:
    FavoriteContainer(favoriteModel: _favoriteModel));
  }
}

class FavoriteContainer extends StatelessWidget {
  const FavoriteContainer({
    Key key,
    @required favorite.FavoriteModel favoriteModel,
  })  : _favoriteModel = favoriteModel,
        super(key: key);

  final favorite.FavoriteModel _favoriteModel;

  @override
  Widget build(BuildContext context) {
    return  !_favoriteModel.status? Container(
      color: Colors.white,
      child: Center(
        child: Text("Not Favorite House",style:TextStyle(color: Colors.black),)
      ),
    ):Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(_favoriteModel.response.length, (index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 5,
              child: InkWell(
                onTap: () {
                  print("-----------------house in home ID:  ${_favoriteModel.response[index].id }-------------------");
                  Navigator.push(context, MaterialPageRoute(builder: (context){return DetailScreen( cID: _favoriteModel.response[index].id,);}));
                },
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
                            image: NetworkImage(
                                _favoriteModel.response[index].mainIcon),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.topRight,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: (){

                              },
                              child: Icon(
                                FontAwesomeIcons.solidHeart,
                                color: kBlueText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(_favoriteModel.response[index].name,
                                  style: TextStyle(color: kGry),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.mapMarkerAlt,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                      _favoriteModel.response[index].location,
                                      style: TextStyle(color: kGry),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
