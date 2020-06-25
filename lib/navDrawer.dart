import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/drawer/gf_drawer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:moverzfax/OtherPages/feedback.dart';
import 'package:moverzfax/auth/signIn.dart';
import 'package:get/get.dart';

void signOut() async {
  await FirebaseAuth.instance.signOut();
  Get.to(SignIn());
}

Widget retNavDrawer() {
  return GFDrawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 50,
          child: Container(
            color: Color(0xFF3871AD),
          ),
        ),
        Container(
          color: Color(0xFF3871AD),
          height: 150,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GFAvatar(
                  size: 65,
                  backgroundColor: Colors.white,
                  child: Text(
                    'M',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.black,
                        fontFamily: 'nunito',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'MoverZfax',
                    style: TextStyle(
                        fontFamily: 'nunito',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'moverZfax@gmail.com',
                    style: TextStyle(
                        fontFamily: 'nunito',
                        fontSize: 16,
                        color: Color(0xFFFFE600)),
                  )
                ],
              )
            ],
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Blog',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: null,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Promotional Videos',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () {
            UrlLauncher.launch(
                "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Video Testimonials',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () {
            UrlLauncher.launch(
                "https://www.youtube.com/playlist?list=PLKe-Zuux9p9vWWUVGyY5SPMO6MpRDjZ5x");
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Feedback',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () {
            Get.to(FeedbackForm());
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Log Out',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () {
            signOut();
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
      ],
    ),
  );
}
