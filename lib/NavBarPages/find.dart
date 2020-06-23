import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:moverzfax/Classes/mover.dart';
import 'package:moverzfax/OtherPages/moversListScreen.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  // ignore: non_constant_identifier_names
  String zipcode = "", USDOTNo = "", MCNo = "";
  bool saveAttempt = false;
  final listOfCountries = ["USA", "Canada", "Russia"];
  final listOfStates = ["New Mexico", "Colorado", "California"];
  final listOfCities = ["New York", "Los Angeles", "Los Santos"];
  String dropdownValue = 'USA';
  String dropdownValue1 = 'New Mexico';
  String dropdownValue2 = 'Los Santos';
  final formKey = GlobalKey<FormState>();

  String serverResponse = 'Server response';

  bool isLoaded = false;
  List<Mover> data = new List();

  fetchData(String apiRoute) async {
    Map map;
    if (USDOTNo.isNotEmpty && MCNo.isNotEmpty) {
      map = {
        "moverMCNo": MCNo,
        "moverUSDOTNo": USDOTNo,
        "moverCountry": dropdownValue,
        "moverState": dropdownValue1,
        "moverCity": dropdownValue2,
        "moverZipCode": zipcode
      };
    } else if (USDOTNo.isNotEmpty) {
      map = {
        "moverUSDOTNo": USDOTNo,
        "moverCountry": dropdownValue,
        "moverState": dropdownValue1,
        "moverCity": dropdownValue2,
        "moverZipCode": zipcode
      };
    } else if (MCNo.isNotEmpty) {
      map = {
        "moverMCNo": MCNo,
        "moverCountry": dropdownValue,
        "moverState": dropdownValue1,
        "moverCity": dropdownValue2,
        "moverZipCode": zipcode
      };
    } else {
      map = {
        "moverCountry": dropdownValue,
        "moverState": dropdownValue1,
        "moverCity": dropdownValue2,
        "moverZipCode": zipcode
      };
    }

    String url = 'http://localhost:27017/movers/$apiRoute';
    print(map);
    var response = await apiRequest(url, map);
    setState(() {
      data = parseMovers(response);
      isLoaded = true;
    });

    print('Documents retrieved');
    print(data.length);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MoversListScreen(data, "findScreen")),
    );
  }

  List<Mover> parseMovers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Mover>((json) => Mover.fromJson(json)).toList();
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  @override
  Widget build(BuildContext context) {
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
                      'Find a Mover',
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
                          MCNo = textValue;
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
                        hintText: 'Enter MC#',
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
                          USDOTNo = textValue;
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
                        hintText: 'Enter USDOT',
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
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Select Country",
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
                          dropdownValue = newValue;
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
                      value: dropdownValue1,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Select State",
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
                          dropdownValue1 = newValue;
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
                      value: dropdownValue2,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Select City",
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
                          dropdownValue2 = newValue;
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
                          zipcode = textValue;
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
                        hintText: 'Enter zipcode',
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
                        if (zipcode.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please Enter ZipCode",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xFF3871AD),
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          data = new List();
                          data.clear();
                          if (USDOTNo.isNotEmpty && MCNo.isNotEmpty) {
                            fetchData("detailedSearchWithBothNo");
                          } else if (USDOTNo.isNotEmpty) {
                            fetchData("detailedSearchWithoutMC");
                          } else if (MCNo.isNotEmpty) {
                            fetchData("detailedSearchWithoutUSDOT");
                          } else {
                            fetchData("detailedSearch");
                          }
                          setState(() {
                            saveAttempt = true;
                          });
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 54.0),
                        decoration: BoxDecoration(
                            color: Color(0xFF3871AD),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Text(
                          'Search',
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
