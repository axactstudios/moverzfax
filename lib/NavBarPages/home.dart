import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:moverzfax/navDrawer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: retNavDrawer(),
      appBar: GFAppBar(
        backgroundColor: Color(0xFF3871AD),
        title: Text(
          "MoverZfax",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'nunito'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF3871AD), width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Enter Name / USDOT# / MC#',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'nunito',
                        color: Colors.black54),
                  ),
                ),
              ),
            ),
            Container(
              height: width * 0.5,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      UrlLauncher.launch("tel://21213123123");
                    },
                    child: Container(
                      height: 0.35 * width,
                      width: 0.35 * width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 10,
                            )
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border:
                              Border.all(color: Color(0xFF3871AD), width: 2.5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            size: width * 0.2,
                            color: Color(0xFF3871AD),
                          ),
                          Text(
                            'Contact Us',
                            style: TextStyle(
                                color: Color(0xFF3871AD),
                                fontFamily: 'nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 0.35 * width,
                    width: 0.35 * width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 10,
                          )
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border:
                            Border.all(color: Color(0xFF3871AD), width: 2.5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.security,
                          size: width * 0.15,
                          color: Color(0xFF3871AD),
                        ),
                        Text(
                          'Special Moving Task Force',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF3871AD),
                              fontFamily: 'nunito',
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.045),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 30, right: 30),
              child: Container(
                child: Image.asset('assets/Banner2.png'),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 10,
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 30, right: 30),
              child: Container(
                child: Image.asset('assets/Banner 1.png'),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 10,
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 30, right: 30),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Moverzfax.com is providing a piece of mind to consumers'
                    ' when it comes to selecting the moving company of their'
                    ' choice. With over 16000 household good movers navigating'
                    ' in the US market and around 36.3% of them operates unethically'
                    ', it is a must to provide tools to consumers in'
                    ' this industry. For the mere price of \$5 dollars'
                    ' per report per moving company, the information is generated by their'
                    ' USDOT license information, and based on that accurate data,'
                    ' key information is added throughout the report when it comes to'
                    ' its reviews and association alike. Do not be fooled with imitation'
                    ' of Moverzfax.com. There is ONLY one site'
                    ' that provides accurate data such as found on Moverzfax.com',
                    style: TextStyle(fontFamily: 'nunito', fontSize: 17),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                    border: Border.all(width: 2, color: Color(0xFF3871AD)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 10,
                      )
                    ]),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
