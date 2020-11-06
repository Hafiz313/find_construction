import 'package:find_construction/models/login_models.dart';
import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/screens/password_verification_screen.dart';
import 'package:find_construction/screens/registration_screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ForgetScreen extends StatefulWidget {
  static const id = "forget_screen";

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

Future<LoginModel> createLogin(String email) async {
  final String apiUrl = "https://construction.bazaaaar.com/passwordRecover.php";
  final response = await http.post(apiUrl, body: {"femail": email});
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return loginModelFromJson(responseString);
  } else {
    return null;
  }
}

final String auth_token = "auth_token";



 emailValidation(String email ){
   Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
   RegExp regex = new RegExp(pattern);
   if (regex.hasMatch(email)) {
     return true;
   }
   else{
     return false;
   }
 }
class _ForgetScreenState extends State<ForgetScreen> {
  var _formKey = GlobalKey<FormState>();
  LoginModel _loginModel;
  SharedPreferences prefs;
  String strEmail;

saveValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('key', value);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Builder(
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
                          child: Text("Forget Password",
                            style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),

                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.only(left: 20,right: 20),
                          alignment: Alignment.center,
                          child: Text("Please enter the email id you use at a time of registration to get password forget instruction.",textAlign: TextAlign.center ,
                            style: TextStyle(color: Colors.black,),

                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kLightGry)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: kLightGry)),
                        labelText: 'Email ',
                        labelStyle: TextStyle(color: kLightGry)),
                    // ignore: missing_return
                    validator: (String value) {
                      if(emailValidation(value)){
                        strEmail= value.toString().trim();
                      }
                      else
                        return "Invalid Email";
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
                       // Navigator.pushNamed(context, PasswordVerificationScreen.id);
                        if (_formKey.currentState.validate()) {
                         LoginModel login = await createLogin(strEmail);
                         setState(() {

                            _loginModel=login;
                         });
                         print("email: $strEmail");

                         if(_loginModel.status){
                           Scaffold.of(context).showSnackBar(SnackBar(content: Text(_loginModel.message)));
                           saveValue(_loginModel.response[0].id);
                           Navigator.pushNamed(context, PasswordVerificationScreen.id);
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
      ),
    );
  }
}
