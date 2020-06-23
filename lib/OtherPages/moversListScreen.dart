import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:getflutter/getflutter.dart';
import 'package:moverzfax/Classes/mover.dart';

// ignore: must_be_immutable
class MoversListScreen extends StatefulWidget {
  List<Mover> moverList;
  String sourcePage;
  MoversListScreen(this.moverList, this.sourcePage);
  @override
  _MoversListScreenState createState() => _MoversListScreenState();
}

class _MoversListScreenState extends State<MoversListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: Color(0xFF3871AD),
        title: Text(
          "MoverZfax",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'nunito'),
        ),
      ),
      body: Column(
        children: <Widget>[
          widget.sourcePage == "findSreenPage"
              ? Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Available Movers',
                    style: TextStyle(
                        color: Color(0xFF3871AD),
                        fontSize: 24,
                        fontFamily: 'nunito',
                        fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Mover Details',
                    style: TextStyle(
                        color: Color(0xFF3871AD),
                        fontSize: 24,
                        fontFamily: 'nunito',
                        fontWeight: FontWeight.bold),
                  ),
                ),
          Expanded(
            child: ListView(
              children: getMoversCards(widget.moverList),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> getMoversCards(List<Mover> moversList) {
  List<Widget> temp = new List();
  for (int i = 0; i < moversList.length; i++) {
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
                  moversList[i].moverName,
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
                        'PhNo- ${moversList[i].moverPhno}',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'nunito',
                            fontSize: 14),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'Rating- ${moversList[i].moverRating}',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'nunito',
                            fontSize: 14),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'USDOT No- ${moversList[i].moverUSDOTNo}',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'nunito',
                            fontSize: 14),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'MC No- ${moversList[i].moverMCNo}',
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
                          'Description- ${moversList[i].moverDescription}',
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
