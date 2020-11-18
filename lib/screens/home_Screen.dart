import 'dart:convert';
import 'dart:io';
import 'package:find_construction/models/house_main_models.dart' as house;
import 'package:find_construction/screens/detail_screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:find_construction/weight/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 
  bool isLoading=true;
  house.HouseMainModel _houseMainModel;
  Position position;
  String userId;
  List<Marker> _markers = <Marker>[];
 // _markers.add(Marker(markerId: MarkerId('SomeId') position: LatLng(38.123,35.123),infoWindow: InfoWindow(title: 'The title of the marker'));

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
  Future<house.HouseMainModel> getHomeLatLng(String lat, String lng) async {
    final String apiUrl = "https://construction.bazaaaar.com/latelong.php";
    final response = await http.post(apiUrl, body: {"lat": lat, "long": lng});
    if (response.statusCode == 200) {
      final String responseString = response.body;

      setState(() {
        _houseMainModel= house.houseMainModelFromJson(responseString);
        isLoading= false;
      });
      print("----------------------Home response ${_houseMainModel.response[0]}----------------------------");
      return house.houseMainModelFromJson(responseString);
    } else {
      setState(() {
        isLoading=false;
      });
      return null;
    }
  }
  Future<house.HouseMainModel> setFavoriteIHouse(String userId,String catId,BuildContext context) async {
    final String apiUrl = "https://construction.bazaaaar.com/favorite.php";
    final response = await http.post(apiUrl, body: {"uid": userId, "cid": catId,"add":""});
    if (response.statusCode == 200) {
      final String responseString = response.body;


      print("----------------------setFavoriteIHouse ${house.houseMainModelFromJson(responseString).message}----------------------------");
      Navigator.pop(context);
      _displaySnackBar(context, house.houseMainModelFromJson(responseString).message);


      return house.houseMainModelFromJson(responseString);
    } else {
      setState(() {
        isLoading=false;
      });
      return null;
    }
  }
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 10), child: Text(" Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  saveValue(double lat,double lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location_lan', lat.toString());
    prefs.setString('location_lng', lng.toString());
  }
  void getLocation() async{
     position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     readID();
    saveValue(position.latitude,position.longitude);

     _markers.add(
         Marker(
           // ignore: deprecated_member_use
           icon: BitmapDescriptor.fromAsset("images/home_marker.png"),
             markerId: MarkerId('SomeId'),
             position: LatLng(position.latitude,position.longitude),
             infoWindow: InfoWindow(
                 title: 'The title of the marker'
             )
         ),
     );

   // getHomeLatLng(position.latitude.toString(),position.longitude.toString());
    getHomeLatLng("34.252525","74.35658");
  }
  Future<void> readID() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId= json.decode(prefs.getString("login_response"))["response"]["id"]?? "";
    });

 }
  _displaySnackBar(BuildContext context,String text) {
    final snackBar = SnackBar(content: Text(text));
    Scaffold.of(context).showSnackBar(snackBar);
  }
  @override
  void initState() {
    super.initState();
    getLocation();

  }
  @override
  Widget build(BuildContext context) {
    return isLoading ? Container(
      color: Colors.white,
      child:
      Center(
        child:SpinKitDualRing(
          color:kBlueText,
          size: 50.0,
        ),
      ),
    ): WillPopScope(
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
          body: Builder(
              builder: (context) =>Center(
              child: SingleChildScrollView(
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
                              mapType: MapType.normal,
                              markers:Set<Marker>.of(_markers),

                              /*onCameraMove:(CameraPosition cameraPosition){
                                print(cameraPosition.zoom);
                              },*/
                              zoomControlsEnabled: false,
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(position.latitude, position.longitude), zoom: 12),
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
                        // itemCount:_houseMainModel.response.length,
                         itemCount:_houseMainModel.response.length,
                          itemBuilder: (context, index) {
                            return Container(
                                height: 200,
                                width: 200,
                                child: InkWell(
                                  onTap: (){
                                    print("-----------------house in home ID:  ${_houseMainModel.response[index].id }-------------------");
                                    Navigator.push(context, MaterialPageRoute(builder: (context){return DetailScreen( cID: _houseMainModel.response[index].id ,);}));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0)),
                                    elevation: 5,
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
                                              image:
                                              DecorationImage(
                                               image:
                                               NetworkImage(_houseMainModel.response[index].mainIcon),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Container(
                                              alignment: Alignment.topRight,
                                              width: double.infinity,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    showAlertDialog(context);
                                                   String strCatId= _houseMainModel.response[index].id;
                                                    print("---------click heart C_id $strCatId  and UserId $userId----------------");
                                                    setFavoriteIHouse(userId, strCatId,context);

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
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(_houseMainModel.response[index].name, style: TextStyle(color: kGry),
                                                      overflow: TextOverflow.ellipsis),
                                                ),
                                                SizedBox(
                                                  height: 10,
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
                                                    Text(
                                                     // "Montacute TA15 6XP, United",
                                                      _houseMainModel.response[index].location,
                                                        overflow: TextOverflow.ellipsis,
                                                      style:
                                                          TextStyle(fontSize: 12),
                                                    )
                                                  ],
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
                          child: ListView.builder(
                             itemCount:_houseMainModel.response.length,
                             // itemCount:30,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    print("-----------------house in home ID:  ${_houseMainModel.response[index].id }-------------------");
                                    Navigator.push(context, MaterialPageRoute(builder: (context){return DetailScreen( cID: _houseMainModel.response[index].id ,);}));

                                  },
                                  child: Card(
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
                                                    NetworkImage(_houseMainModel.response[index].mainIcon),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )),
                                          Expanded (
                                              flex: 3,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(_houseMainModel.response[index].name, style: TextStyle(color: kGry),
                                                        overflow: TextOverflow.ellipsis),
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
                                                          Text(_houseMainModel.response[index].location,
                                                              overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(

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
                                                              Container(
                                                                child: Text(
                                                                 " ${_houseMainModel.response[index].area}",
                                                                    overflow: TextOverflow.ellipsis,
                                                                //  '2100 sqft',
                                                                  style: TextStyle(
                                                                      fontSize: 12),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                FontAwesomeIcons.bed,
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '${_houseMainModel.response[index].bedroom} bedrooms',


                                                              //  "3 bedrooms",
                                                                style: TextStyle(
                                                                    fontSize: 12),
                                                                overflow: TextOverflow.ellipsis,
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
                                  ),
                                );
                              }))
                    ],
                  ),
                ),
              ),
            )),
          ));

  }
}
