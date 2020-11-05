import 'package:find_construction/models/login_models.dart';
import 'package:find_construction/screens/login_screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home_Screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

Future<LoginModel> createSinUp(String name, String phone, String address,
    String email, String password) async {
  final String apiUrl = "https://construction.bazaaaar.com/signup.php";
  final response = await http.post(apiUrl, body: {
    "name": name,
    "phone": phone,
    "address": address,
    "email": email,
    "password": password
  });
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return loginModelFromJson(responseString);
  } else {
    return null;
  }
}

emailValidation(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (regex.hasMatch(email)) {
    return true;
  } else {
    return false;
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  LoginModel _loginModel;
  String strName,
      strEmail,
      strAddress,
      strPhone,
      strConformPassword,
      strPassword;
  String empty ="Empty !";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Registration",
                    style: TextStyle(color: kBlueText, fontSize: 30),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kLightGry)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: kLightGry)),
                        labelText: 'Name ',
                        labelStyle: TextStyle(color: kLightGry)),
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return empty;
                      } else
                        strName = value.toString().trim();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                      if (value.isEmpty)
                        return "Empty !";
                      else if (emailValidation(value)){
                        strEmail= value.toString().trim();
                      }
                      else
                        return "Invalid Email";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kLightGry)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: kLightGry)),
                        labelText: 'Address ',
                        labelStyle: TextStyle(color: kLightGry)),
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return empty;
                      } else
                        strAddress = value.toString().trim();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kLightGry)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: kLightGry)),
                        labelText: 'Telephone ',
                        labelStyle: TextStyle(color: kLightGry)),
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return empty;
                      } else
                        strPhone = value.toString().trim();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _pass,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kLightGry)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: kLightGry)),
                        labelText: 'Password ',
                        labelStyle: TextStyle(color: kLightGry)),
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return empty;
                      } else
                        strPassword = value.toString().trim();
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _confirmPass,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kLightGry)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: kLightGry)),
                        labelText: 'Confrim Password ',
                        labelStyle: TextStyle(color: kLightGry)),
                    // ignore: missing_return
                    validator: (String val) {
                      if (val.isEmpty) return empty;
                      if (val != _pass.text) return 'Not Match';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      color: kBlueText,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(10.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          LoginModel sinUp = await createSinUp(
                              strName,
                              strPhone,
                              strAddress,
                              strEmail,
                              strPassword);

                          setState(() {
                            _loginModel = sinUp;
                          });
                          print(
                              "email: $strEmail and Password $strPassword");

                          if (_loginModel.status) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(_loginModel.message)));
                            Navigator.pushReplacementNamed(context, HomeScreen.id);
                          } else
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(_loginModel.message)));
                        }
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 15, color: kGry),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text(
                          "Sign up",
                          style:
                              TextStyle(color: kBlueText, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
