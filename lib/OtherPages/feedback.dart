import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> send() async {
    final Email email = Email(
      body:
          'Name-$fullName\nPhone-$phone\nAddress-$currAdd, $currDropdownValue2, $currDropdownValue1, $currDropdownValue\nMessage- $msg',
      subject: "Feedback",
      recipients: ['axactstudios@gmail.com'],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;
    print(platformResponse);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  String phone = "", fullName = "", currAdd = "", msg = "";
  bool saveAttempt = false;
  final listOfCountries = ["USA", "Canada", "Russia"];
  final listOfStates = ["New Mexico", "Colorado", "California"];
  final listOfCities = ["New York", "Los Angeles", "Los Santos"];
  String currDropdownValue = 'USA';
  String currDropdownValue1 = 'New Mexico';
  String currDropdownValue2 = 'Los Santos';
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      'Your Reviews are valuable to us.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF3871AD),
                          fontSize: 22,
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
                          phone = textValue;
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
                        hintText: 'Phone',
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
                        hintText: 'Address',
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
                        labelText: "Country",
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
                        labelText: "State",
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
                        labelText: "City",
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
                      maxLines: 5,
                      minLines: 4,
                      onChanged: (textValue) {
                        setState(() {
                          msg = textValue;
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
                        hintText: 'Message',
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
                          send();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 54.0),
                        decoration: BoxDecoration(
                            color: Color(0xFF3871AD),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Text(
                          'Submit',
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
}
