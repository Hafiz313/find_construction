import 'package:find_construction/screens/login_screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
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
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kLightGry)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: kLightGry)),
                      labelText: 'Name ',
                      labelStyle: TextStyle(color: kLightGry)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kLightGry)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: kLightGry)),
                      labelText: 'Email ',
                      labelStyle: TextStyle(color: kLightGry)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kLightGry)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: kLightGry)),
                      labelText: 'Address ',
                      labelStyle: TextStyle(color: kLightGry)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kLightGry)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: kLightGry)),
                      labelText: 'Telephone ',
                      labelStyle: TextStyle(color: kLightGry)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kLightGry)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: kLightGry)),
                      labelText: 'Password ',
                      labelStyle: TextStyle(color: kLightGry)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kLightGry)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: kLightGry)),
                      labelText: 'Confrim Password ',
                      labelStyle: TextStyle(color: kLightGry)),
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
                    onPressed: () {},
                    child: Text(
                      "Sign in",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
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
                        "Sign in",
                        style: TextStyle(color: kBlueText, fontSize: 15),
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
    );
  }
}
