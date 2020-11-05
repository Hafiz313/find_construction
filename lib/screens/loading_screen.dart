import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  void getLocation() async{

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("lat : ${position.latitude} and lon : ${position.longitude}");
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
