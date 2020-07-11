import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:moverzfax/Classes/posts.dart';
import 'package:moverzfax/OtherPages/jobPostForm.dart';
import 'package:moverzfax/auth/signIn.dart';

class JobPage extends StatefulWidget {
  final String userEmail;
  JobPage(this.userEmail);
  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
//  FirebaseUser _user;

  String serverResponse = 'Server response';

  bool isLoaded = false;
  List<Post> data = new List();

  fetchData(String userEmail) async {
//    FirebaseUser user = await mAuth.currentUser();
//    _user = user;
//    setState(() {
//      _user = user;
//    });

    Map map;
    final url =
        "https://whispering-meadow-64251.herokuapp.com/posts/findMultiple";
    map = {"userEmail": userEmail};
    print(map);
    var response = await apiRequest(url, map);

    setState(() {
      data = parsePosts(response);
      print('Data length is ${data.length}');
      isLoaded = true;
    });

    print('Documents retrieved');
    print(data.length);
  }

  List<Post> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  @override
  void initState() {
    fetchData(widget.userEmail);

    super.initState();
  }

  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
                onTap: () async {
                  var user = await mAuth.currentUser();
                  if (user == null) {
                    print('Hihihihihihihi');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Login"),
                            content:
                                Text("To post a job you must be logged in."),
                            actions: [
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("Login"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()));
                                },
                              )
                            ],
                          );
                        });
                  } else {
                    print(mAuth.currentUser());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JobPostForm()),
                    );
                  } //gfgfgfgfg
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF24408F),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          'Post a new job',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'nunito'),
                        ),
                      ),
                    ))),
          ),
          Expanded(
            child: data.length != null
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      print('No of objects is ${data.length}');
                      return _getJobCard(data[index], width);
                    })
                : CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
          )
        ],
      ),
    );
  }
}

Widget _getJobCard(Post jobPosted, double width) {
  return Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: Color(0xFF3871AD).withOpacity(0.9),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15, 0, 5),
          child: Text(
            jobPosted.fullName,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Color(0xFFFFE600),
                fontFamily: 'nunito',
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: (width - 60) / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
                    child: Text(
                      jobPosted.currAdd,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'nunito',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
                    child: Text(
                      ' ${jobPosted.currCity} , ${jobPosted.currState} , ${jobPosted.currCountry}',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'nunito',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 15),
                    child: Text(
                      jobPosted.currZip,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'nunito',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              size: 24,
              color: Colors.white,
            ),
            Container(
              width: (width - 60) / 2,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
                    child: Text(
                      jobPosted.destAdd,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'nunito',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
                    child: Text(
                      '${jobPosted.destCity} , ${jobPosted.destState} , ${jobPosted.destCountry}',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'nunito',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 15),
                    child: Text(
                      jobPosted.destZip,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'nunito',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}
