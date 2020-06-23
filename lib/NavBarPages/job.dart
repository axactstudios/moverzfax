import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:moverzfax/OtherPages/jobPostForm.dart';

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
          )
        ],
      ),
    );
  }
}
