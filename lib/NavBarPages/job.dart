import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:moverzfax/Classes/posts.dart';
import 'package:moverzfax/OtherPages/jobPostForm.dart';
import 'package:http/http.dart' as http;

class JobPage extends StatefulWidget {
  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  FirebaseUser _user;
  void getUserDetails() async {
    FirebaseUser user = await mAuth.currentUser();
    _user = user;
    setState(() {
      _user = user;
    });
  }

  String serverResponse = 'Server response';

  bool isLoaded = false;
  List<Post> data = new List();

  fetchData() async {
    final url = "http://localhost:5000/getData";
    var res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': _user.uid,
        }));
    print(1);
    var response = jsonDecode(res.body).toString();
    print(2);

    setState(() {
      print(2);
      data = parsePosts(response);
      isLoaded = true;
    });

    print('Documents retrieved');
    print(data.length);
  }

  List<Post> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  @override
  void initState() {
    getUserDetails();
    fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserDetails();

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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JobPostForm()),
                  );
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
                onTap: () {
                  fetchData();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF24408F),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          'Load',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'nunito'),
                        ),
                      ),
                    ))),
          )
        ],
      ),
    );
  }
}

List<Widget> getPostCards(List<Post> postsList) {
  List<Widget> temp = new List();
  for (int i = 0; i < postsList.length; i++) {
    temp.add(Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
      child: Container(
        height: 218,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 10,
              )
            ],
            color: Color(0xFF24408F),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: <Widget>[
            Container(
              height: 45,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                child: Text(
                  postsList[i].fullName,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            SizedBox(
              height: 120,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 44,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'PhNo- ${postsList[i].currAdd}',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'nunito',
                            fontSize: 14),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'Rating- ${postsList[i].currCity}',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'nunito',
                            fontSize: 14),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'USDOT No- ${postsList[i].destAdd}',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'nunito',
                            fontSize: 14),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'MC No- ${postsList[i].destCity}',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'nunito',
                            fontSize: 14),
                        overflow: TextOverflow.fade,
                      ),
                      SizedBox(
                        height: 30,
                        width: 230,
                        child: Text(
                          'Description- ${postsList[i].destZip}',
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'nunito',
                              fontSize: 14),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color(0xFF424242),
              ),
              child: Center(
                child: Text(
                  'Order A report',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'nunito',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  return temp;
}
