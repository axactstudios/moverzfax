import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:moverzfax/auth/signIn.dart';

class JobPostForm extends StatefulWidget {
  @override
  _JobPostFormState createState() => _JobPostFormState();
}

class _JobPostFormState extends State<JobPostForm> {
  String currZip = "", fullName = "", currAdd = "", destAdd = "", destZip = "";
  bool saveAttempt = false;
  final listOfCountries = ["USA", "Canada", "Russia"];
  final listOfStates = ["New Mexico", "Colorado", "California"];
  final listOfCities = ["New York", "Los Angeles", "Los Santos"];
  String currDropdownValue = 'USA';
  String currDropdownValue1 = 'New Mexico';
  String currDropdownValue2 = 'Los Santos';
  String destDropdownValue = 'USA';
  String destDropdownValue1 = 'New Mexico';
  String destDropdownValue2 = 'Los Santos';
  final formKey = GlobalKey<FormState>();
  FirebaseAuth mAuth = FirebaseAuth.instance;
  FirebaseUser _user;
  void getUserDetails() async {
    FirebaseUser user = await mAuth.currentUser();
    _user = user;
    setState(() {
      _user = user;
      print(_user.uid);
    });
  }

  @override
  void initState() {
    getUserDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_user.uid);
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: Color(0xFF3871AD),
        title: Text(
          "MoverZfax",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'nunito'),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  children: [
                    Text(
                      'Enter Job Details',
                      style: TextStyle(
                          color: Color(0xFF3871AD),
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      onChanged: (textValue) {
                        setState(() {
                          fullName = textValue;
                        });
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
                        hintText: 'Full Name',
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
                          currAdd = textValue;
                        });
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
                        hintText: 'Current Address',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                      value: currDropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Current Country",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3871AD),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listOfCountries.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          currDropdownValue = newValue;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Select Country';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                      value: currDropdownValue1,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Current State",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3871AD),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listOfStates.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          currDropdownValue1 = newValue;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Select State';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                      value: currDropdownValue2,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Current City",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3871AD),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listOfCities.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          currDropdownValue2 = newValue;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Select City';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onChanged: (textValue) {
                        setState(() {
                          currZip = textValue;
                        });
                      },
                      autovalidate: saveAttempt,
                      validator: (nameValue) => nameValue.isEmpty
                          ? 'This field cannot be blank'
                          : null,
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
                        hintText: 'Current zipcode',
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
                          currAdd = textValue;
                        });
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
                        hintText: 'Destination Address',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                      value: destDropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Destination Country",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3871AD),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listOfCountries.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          destDropdownValue = newValue;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Select Country';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                      value: destDropdownValue1,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Destination State",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3871AD),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listOfStates.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          destDropdownValue1 = newValue;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Select State';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                      value: destDropdownValue2,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Destination City",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3871AD),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: listOfCities.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          destDropdownValue2 = newValue;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Select City';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onChanged: (textValue) {
                        setState(() {
                          destZip = textValue;
                        });
                      },
                      autovalidate: saveAttempt,
                      validator: (nameValue) => nameValue.isEmpty
                          ? 'This field cannot be blank'
                          : null,
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
                        hintText: 'Destination zipcode',
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
                          'Post',
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
          ],
        ),
      ),
    );
  }

  _addPost() async {
    String url = 'http://localhost:5000/post';

    print(fullName);
    Map map = {
      'id': _user.uid,
      'fullName': fullName,
      'currAdd': currAdd,
      'currDropdownValue': currDropdownValue,
      'currDropdownValue1': currDropdownValue1,
      'currDropdownValue2': currDropdownValue2,
      'currZip': currZip,
      'destDropdownValue': destDropdownValue,
      'destDropdownValue1': destDropdownValue1,
      'destDropdownValue2': destDropdownValue2,
      'destZip': destZip
    };

    await apiRequest(url, map).then((authResult) => print(authResult));
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
    if (reply == 'done') {
      Navigator.pop(context);
    }
    httpClient.close();

    print(reply);
    showToast(reply, Colors.yellow);

    return reply;
  }
}
