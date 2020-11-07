import 'dart:convert';

import 'package:find_construction/models/login_models.dart';
import 'package:find_construction/screens/forget_screen.dart';
import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/screens/registration_screen.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as JSON;

import 'loading_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Future<LoginModel> createLogin(String email, String password) async {
  final String apiUrl = "https://construction.bazaaaar.com/signin.php";
  final response = await http.post(apiUrl, body: {"email": email, "password": password});
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return loginModelFromJson(responseString);
  } else {
    return null;
  }
}


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

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  LoginModel _loginModel;
  String strEmail, strPassword;
  GoogleSignIn _googleSignIn=GoogleSignIn(scopes:['email']);
  //final facebookLogin = FacebookLogin();

  @override
  void initState() {
   // facebookLogin.loginBehavior=FacebookLoginBehavior.webViewOnly;
    super.initState();
  }

  /* static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';

  Future<Null> _login() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!

         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }*/

  /*Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }*/
  saveValue(String responseData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map json = jsonDecode(responseData);
    String user = jsonEncode(LoginModel.fromJson(json));
    prefs.setString('login_response', user);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      "Log in",
                      style: TextStyle(color: kBlueText, fontSize: 30),
                    ),
                    SizedBox(
                      height: 60,
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
                        else if (emailValidation(value.trim())){
                          strEmail= value.toString().trim();
                        }
                        else
                          return "Invalid Email";
                        }

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: true,
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
                          return "Empty !";
                        }
                        else
                          strPassword=value.toString().trim();
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
                        splashColor: kButtonBG,
                        onPressed: () async {

                          if (_formKey.currentState.validate()) {
                           LoginModel login = await createLogin(strEmail, strPassword);

                           setState(() {
                              _loginModel=login;
                           });
                           print("email: $strEmail and Password $strPassword");
                           


                           if(_loginModel.status){
                             print("---------login ${_loginModel.response[0]}----------");
                             Scaffold.of(context).showSnackBar(SnackBar(content: Text(_loginModel.message)));
                              Navigator.pushReplacementNamed(context, LoadingScreen.id);
                           }
                           else
                             Scaffold.of(context).showSnackBar(SnackBar(content: Text(_loginModel.message)));
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                         Navigator.pushNamed(context, ForgetScreen.id);
                         // Navigator.pushNamed(context, LoadingScreen.id);
                        },
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(color: kLightGry, fontSize: 15),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                            Navigator.pushReplacementNamed(context, RegistrationScreen.id);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: kBlueText, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: kGry,
                              height: 36,
                            )),
                      ),
                      Text(
                        "OR",
                        style: TextStyle(color: kGry),
                      ),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: kGry,
                              height: 36,
                            )),
                      ),
                    ]),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text('Sign up with social network'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async{
                                try{
                                         //    _fbLogin();
                                  print("facebook login");
                                }
                                catch(e){
                                  print(e);
                                }


                              },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Image(
                                    image: AssetImage('images/fb.png'),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async{
                                try{
                                  _googleSignIn.signOut();
                                  await _googleSignIn.signIn().then((value) {
                                    final String name=_googleSignIn.currentUser.displayName;
                                    final String email=_googleSignIn.currentUser.email;
                                    final String id=_googleSignIn.currentUser.id;
                                    final String pic=_googleSignIn.currentUser.photoUrl;

                                    print("name $name");
                                    print("email $email");
                                    print("id $id");
                                    print("picture $pic");
                                  });
                                }
                                catch(err)
                                {
                                  print(err);
                                }

                              },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Image(
                                    image: AssetImage('images/gplus.png'),
                                  )),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*_fbLogin() async{
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:

        final fbToken = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),email&access_token=$fbToken');

        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile.toString());


        final String name=profile['name'];
        final String gid=profile['id'];
        final String pic=profile["picture"]["data"]["url"];
        final String email=profile["email"];



        final String password="";




        break;
      case FacebookLoginStatus.cancelledByUser:
        Fluttertoast.showToast(msg:"Facebook login cancelled by User");

        break;
      case FacebookLoginStatus.error:
        Fluttertoast.showToast(msg:result.errorMessage);
        break;
    }

  }*/
  }

