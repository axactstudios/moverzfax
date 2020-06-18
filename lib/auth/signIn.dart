import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moverzfax/auth/signUp.dart';

import '../main.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

void showToast(message, Color color) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: color,
    textColor: Color(0xFF345995),
    fontSize: 16.0,
  );
}

class _SignInState extends State<SignIn> {
  String email, password;
  bool saveAttempt = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3871AD),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          height: MediaQuery.of(context).size.height - 120,
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Color(0xFF3871AD),
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    onChanged: (textValue) {
                      setState(() {
                        email = textValue;
                      });
                    },
                    autovalidate: saveAttempt,
                    validator: (emailValue) {
                      if (emailValue.isEmpty) {
                        return 'This field cannot be blank';
                      }
                      RegExp regExp = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (regExp.hasMatch(emailValue)) {
                        return null;
                      }

                      return 'Please enter a valid email';
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF3871AD),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF3871AD),
                        ),
                      ),
                      hintText: 'Enter Email',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    onChanged: (textValue) {
                      setState(() {
                        password = textValue;
                      });
                    },
                    autovalidate: saveAttempt,
                    validator: (pwValue) =>
                        pwValue.isEmpty ? 'This field cannot be blank' : null,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF3871AD),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF3871AD),
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        saveAttempt = true;
                      });
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        _addPost();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 54.0),
                      decoration: BoxDecoration(
                          color: Color(0xFF3871AD),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Text(
                        'Enter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return new MaterialApp(
                          theme: ThemeData(
                            scaffoldBackgroundColor: Colors.white,
                            primaryColor: Colors.white,
                          ),
                          home: SignUp(),
                        );
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 54.0),
                      decoration: BoxDecoration(
                          color: Color(0xFF3871AD),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
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

  _addPost() async {
    String url = 'http://localhost:5000/login';
    print(email);
    Map map = {'email': email, 'password': password};

    await apiRequest(url, map);
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    // ignore: close_sinks
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response =
        await request.close().timeout(Duration(seconds: 10));

    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    showToast(reply, Colors.yellow);
    if (reply == 'Something went wrong.') {
      return null;
    } else if (reply == 'Signed in!!') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return new MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white,
          ),
          home: Home(),
        );
      }));
    }

    return reply;
  }
}
