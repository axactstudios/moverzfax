import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moverzfax/Classes/mover.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

Widget MoverDetailsPullUp(
    {BuildContext context, double height, double width, Mover mover}) {
  return Container(
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 30.0, // soften the shadow
            spreadRadius: 3.0, //extend the shadow
            offset: Offset(
              0.0, // Move to right 10  horizontally
              0.0, // Move to bottom 10 Vertically
            ),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
    padding: EdgeInsets.all(15),
    height: height,
    width: width,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mover.moverName,
                style: TextStyle(
                    color: Color(0xFF3871AD),
                    fontFamily: 'nunito',
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.network(
                          'https://picsum.photos/200/300?grayscale',
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Rating- ${mover.moverRating}',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'USDOT No.- ${mover.moverUSDOTNo}',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'MC No.- ${mover.moverMCNo}',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Address- ${mover.moverCountry}, ${mover.moverState}, ${mover.moverCity}',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'ZipCode- ${mover.moverZipCode}',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Contact No. ${mover.moverPhno}',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Description-',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      mover.moverDescription,
                      style: TextStyle(
                          color: Color(0xFF808080),
                          fontFamily: 'nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: null,
                      child: Card(
                        color: Color(0xFF3871AD),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Add to wishlist',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'nunito',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
