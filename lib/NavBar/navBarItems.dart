import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

//factcheck,rule
List<PersistentBottomNavBarItem> navBarItems = [
  PersistentBottomNavBarItem(
    icon: Icon(FontAwesomeIcons.home),
    title: ("Home"),
    activeColor: Color(0xFF3871AD),
    inactiveColor: Colors.black87,
  ),
  PersistentBottomNavBarItem(
    icon: Icon(FontAwesomeIcons.search),
    title: ("Find"),
    activeColor: Color(0xFF3871AD),
    inactiveColor: Colors.black87,
  ),
  PersistentBottomNavBarItem(
    icon: Icon(FontAwesomeIcons.shoppingBag),
    title: ("Order"),
    activeColor: Color(0xFF3871AD),
    inactiveColor: Colors.black87,
  ),
  PersistentBottomNavBarItem(
    icon: Icon(FontAwesomeIcons.plus),
    title: ("Post a Job"),
    activeColor: Color(0xFF3871AD),
    inactiveColor: Colors.black87,
  ),
];
