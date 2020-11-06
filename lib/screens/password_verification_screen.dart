import 'package:find_construction/models/login_models.dart';
import 'package:find_construction/screens/conformed_password_screen.dart';
import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/screens/registration_screen.dart';
import 'package:find_construction/utils/app_color.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PasswordVerificationScreen extends StatefulWidget {
  static const id = "password_verification_screen";

  @override
  _PasswordVerificationScreenState createState() => _PasswordVerificationScreenState();
}

Future<LoginModel> createVerified(String code,String id) async {
  final String apiUrl = "https://construction.bazaaaar.com/passwordRecover.php";
  final response = await http.post(apiUrl, body: {"code": code,"id": id});
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return loginModelFromJson(responseString);
  } else {
    return null;
  }
}

class _PasswordVerificationScreenState extends State<PasswordVerificationScreen> {
  var _formKey = GlobalKey<FormState>();
  String strTitle= "Verification";
  String strDescription= "Please enter you code send to your email.";
  String strLabelText= 'Code';
  LoginModel _loginModel;
  String strCode;
  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('key');
    return stringValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) => Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('images/moble.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(strTitle,
                          style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),

                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.only(left: 20,right: 20),
                        alignment: Alignment.center,
                        child: Text(strDescription,textAlign: TextAlign.center ,
                          style: TextStyle(color: Colors.black,),

                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kLightGry)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: kLightGry)),
                      labelText:  strLabelText,
                      labelStyle: TextStyle(color: kLightGry)),
                  // ignore: missing_return
                  validator: (String value) {
                    if(value.length >= 4){
                      strCode= value.toString().trim();
                    }
                    else
                      return "Must 4 digits";
                  },
                ),
                SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    color: kBlueText,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(10.0),
                    splashColor: kButtonBG,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {

                        String id = await getValue() ?? "";
                       LoginModel login = await createVerified(strCode,id);
                       setState(() {
                          _loginModel=login;
                       });
                       print("code: $strCode and id $id");

                       if(_loginModel.status){
                         Scaffold.of(context).showSnackBar(SnackBar(content: Text(_loginModel.message)));
                          Navigator.pushNamed(context, ConfermedPasswordScreen.id);
                       }
                       else
                         Scaffold.of(context).showSnackBar(SnackBar(content: Text(_loginModel.message)));
                      }
                    },
                    child: Text(
                      "Get Code",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
