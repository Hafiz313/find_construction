import 'dart:convert';

import 'package:find_construction/models/login_models.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:find_construction/weight/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static const id = "profile_screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String strName="", strMail="", strAddress="", strPhoneNo="";

  @override
  void initState() {
    super.initState();
    read();
  }

  Future<void> read() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      strName =
          json.decode(prefs.getString("login_response"))["response"][0]["name"]?? "";
      strMail = json.decode(prefs.getString("login_response"))["response"][0]
          ["email"] ?? "";
      strAddress = json.decode(prefs.getString("login_response"))["response"][0]
          ["address"] ?? "";
      strPhoneNo = json.decode(prefs.getString("login_response"))["response"][0]
          ["phone"] ?? "";
    });
    print(
        "-----------------------login data in profile ${json.decode(prefs.getString("login_response"))["response"][0]["name"]}-------------------");
    print("-----------$strName m $strMail, add $strAddress and $strPhoneNo");
    return json.decode(prefs.getString("login_response"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBlueText,
          title: Text("Profile"),
        ),
        drawer: HomeDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200.0,
                color: kBlueText,
                child: Align(
                  alignment: const Alignment(0, 1.0),
                  child: SizedBox(
                    width: 8.0,
                    height: 10.0,
                    child: OverflowBox(
                      minWidth: 0.0,
                      maxWidth: 120.0,
                      minHeight: 0.0,
                      maxHeight: 120.0,
                      child: Container(
                        child: CircleAvatar(
                          backgroundImage: ExactAssetImage('images/bg.png'),
                          minRadius: 90,
                          maxRadius: 150,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Name",
                        style: TextStyle(
                          color: kBlueText,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                          "$strName",

                        style: TextStyle(
                          color: kGry,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Divider(color: kGryBG, thickness: 1)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Gmail ",
                        style: TextStyle(
                          color: kBlueText,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                         "$strMail",
                        style: TextStyle(
                          color: kGry,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Divider(color: kGryBG, thickness: 1)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Address ",
                        style: TextStyle(
                          color: kBlueText,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                          "$strAddress",

                        style: TextStyle(
                          color: kGry,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Divider(color: kGryBG, thickness: 1)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Phone Number ",
                        style: TextStyle(
                          color: kBlueText,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "$strPhoneNo",

                        style: TextStyle(
                          color: kGry,
                        ),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Divider(color: kGryBG, thickness: 1)
                  ],
                ),
              ),
            ],
          ),
        ),

        /*Container(
          height: 300,
          width: double.infinity,
          color: kBlueText,
          child: Column(
            children: [

              Stack(

                children: [
                  Container(
                    height: 100,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/home_bg.png'),
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat,
                      ),
                    ),
                  ),
                  OverflowBox(
                    minWidth: 0.0,
                    maxWidth: 10.0,
                    minHeight: 0.0,
                    maxHeight: 10.0,
                    child: Container(
                      height: 20,
                      width: 20,
                      color: Colors.grey,
                    ),
                  )
                ],
              )

            ],
          ),
        ),*/
      ),
    );
  }
}
