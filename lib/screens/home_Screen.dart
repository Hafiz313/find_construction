import 'dart:io';
import 'package:find_construction/models/home_house_models.dart';
import 'package:find_construction/screens/detail_screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:find_construction/weight/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const id = "home_screen";
   final HouseHomeModel houseHomeModel;
   final double lat,lng;
  const HomeScreen({Key key, this.houseHomeModel, this.lat, this.lng}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double doubleLat, doubleLng;
  String strLat, strLng;

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }
  @override
  void initState() {
    super.initState();
    print("---------------response of data ${widget.houseHomeModel.message}----------------");
    print("---------------lat: ${widget.lat} and lng : ${widget.lng}----------------");
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Find Construction Home'),
            /*  leading: IconButton(
                icon: Icon(FontAwesomeIcons.alignLeft),
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
                tooltip:  MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),*/

            actions: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
          ),
          drawer: HomeDrawer(),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            alignment: Alignment.center,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, right: 10, left: 10),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    color: kButtonBG,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      /** */
                    },
                  ),
                ),
                Container(
                  child: FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, right: 10, left: 10),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.phoneAlt,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Call',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    color: kButtonBG,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      /** */
                    },
                  ),
                ),
                Container(
                  child: FlatButton(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, right: 10, left: 10),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.shareAlt,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Share',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    color: kButtonBG,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      /** */
                    },
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    child: Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GoogleMap(
                          tiltGesturesEnabled: false,
                          onCameraMove:(CameraPosition cameraPosition){
                            print(cameraPosition.zoom);
                          },
                          zoomControlsEnabled: false,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(widget.lat, widget.lng), zoom: 12),
                        ),
                      ),
                    )),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      "Best Project",
                      style: TextStyle(
                        color: kGry,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:widget.houseHomeModel.response.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 200,
                            width: 200,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              elevation: 5,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, DetailScreen.id);
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
                                              child: Text(
                                                widget.houseHomeModel.response[index].name,
                                                style: TextStyle(color: kGry),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.mapMarkerAlt,
                                                    size: 12,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    widget.houseHomeModel.response[index].location,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      "New Arrivel",
                      style: TextStyle(
                        color: kGry,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                      height: 220,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, DetailScreen.id);
                        },
                        child: ListView.builder(
                            itemCount:widget.houseHomeModel.response.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 5,
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(10.0),
                                                bottomLeft:
                                                    const Radius.circular(10.0),
                                              ),
                                              image: DecorationImage(
                                                image:
                                                    AssetImage("images/bg.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )),
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    widget.houseHomeModel.response[index].name,
                                                    style: TextStyle(color: kGry),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .mapMarkerAlt,
                                                        size: 12,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        widget.houseHomeModel.response[index].location,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .borderAll,
                                                            size: 12,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            '2100 sqft',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons.bed,
                                                            size: 12,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            '${widget.houseHomeModel.response[index].bedroom} bedrooms',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
