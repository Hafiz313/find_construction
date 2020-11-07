import 'package:find_construction/models/home_house_models.dart';
import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
class LoadingScreen extends StatefulWidget {

  static const id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double doubleLat, doubleLng;
  String strLat, strLng;
  HouseHomeModel _houseHomeModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();

  }

  Future<HouseHomeModel> getHomeLatLng(String lat, String lng) async {
    final String apiUrl = "https://construction.bazaaaar.com/latelong.php";
    final response = await http.post(apiUrl, body: {"lat": lat, "long": lng});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return houseHomeModelFromJson(responseString);
    } else {
      return null;
    }
  }
  saveValue(double lat,double lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location_lan', lat.toString());
    prefs.setString('location_lng', lng.toString());
  }
  void getLocation() async{

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("---------------lat : ${position.latitude} and lon : ${position.longitude}--------------");
    saveValue(position.latitude,position.longitude);
    //HouseHomeModel items = await getHomeLatLng("31.4982817", "74.2856941");
   HouseHomeModel items = await getHomeLatLng(position.latitude.toString(),position.longitude.toString());
    setState(() {
      _houseHomeModel = items;
    });
    print("----------------------response ${_houseHomeModel.message}----------------------------");
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return HomeScreen(houseHomeModel: _houseHomeModel,
     lat: position.latitude,lng: position.longitude,);}));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGryBG,
      body: Center(
        child: SpinKitDoubleBounce(
          color:kBlueText,
          size: 100.0,
        ),


      ),
    );
  }
}
