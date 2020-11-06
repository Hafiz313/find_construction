import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoadingScreen extends StatefulWidget {

  static const id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();

  }
  saveValue(double lat,double lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location_lan', lat.toString());
    prefs.setString('location_lng', lng.toString());
  }






  void getLocation() async{

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   // print("lat : ${position.latitude} and lon : ${position.longitude}");
    saveValue(position.latitude,position.longitude);
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return HomeScreen();
    }));

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
