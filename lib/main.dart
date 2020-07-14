import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moverzfax/OtherPages/SplashScreen.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-bottom-nav-bar-styles.widget.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.widget.dart';
import 'package:splashscreen/splashscreen.dart';
import 'NavBar/navBarItems.dart';
import 'NavBarPages/find.dart';
import 'NavBarPages/home.dart';
import 'NavBarPages/job.dart';
import 'NavBarPages/order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 7,
      backgroundColor: Colors.black,
      image: Image.asset(
        'assets/loading.gif',
      ),
      loaderColor: Colors.transparent,
      photoSize: 200,
      navigateAfterSeconds: null,
    );
  }
}

class Home extends StatefulWidget {
  final String userEmail;
  Home({this.userEmail});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      items: navBarItems,
      screens: _buildScreens(),
      showElevation: true,
      navBarCurve: NavBarCurve.upperCorners,
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      iconSize: 26.0,
      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property
      onItemSelected: (index) {
        print(index);
      },
    );
  }

  List<Widget> _buildScreens() {
    return [HomePage(), FindPage(), OrderPage(), JobPage(widget.userEmail)];
  }
}
