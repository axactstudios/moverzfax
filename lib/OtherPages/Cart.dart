import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:moverzfax/Classes/CartItem.dart';

class Cart extends StatefulWidget {
  List<CartItem> cartList;
  Cart(this.cartList);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String allMoversOrdered;

  @override
  void initState() {
    allMoversOrdered = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: Color(0xFF3871AD),
        title: Text(
          "MoverZfax",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'nunito',
              color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: widget.cartList.length,
                  itemBuilder: (context, index) {
                    var item = widget.cartList[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        color: Color(0xFF3871AD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                item.moverName,
                                style: TextStyle(
                                    fontFamily: 'nunito',
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              CircleAvatar(
                                radius: 25.0,
                                child: Text(
                                  '\$5',
                                  style: TextStyle(
                                      fontFamily: 'nunito', fontSize: 20.0),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              GestureDetector(
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      widget.cartList.remove(item);
                                    });
                                    Fluttertoast.showToast(
                                        msg: 'Removed from cart',
                                        gravity: ToastGravity.CENTER,
                                        toastLength: Toast.LENGTH_SHORT);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Container(
            height: 150.0,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF3871AD),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Order amount : \$${widget.cartList.length * 5}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'nunito',
                        fontSize: 25.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    color: Colors.white,
                    onPressed: () {
                      sendEmail();
                      addOrders();
                    },
                    child: Text(
                      'Proceed to pay',
                      style: TextStyle(
                          color: Color(0xFF3871AD),
                          fontFamily: 'nunito',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendEmail() async {
    FirebaseAuth mAuth = FirebaseAuth.instance;
    FirebaseUser user = await mAuth.currentUser();

    allMoversOrdered = allMoversOrdered + widget.cartList[0].moverName;
    for (int i = 1; i < widget.cartList.length; i++) {
      allMoversOrdered =
          allMoversOrdered + ' , ' + widget.cartList[i].moverName;
    }

    allMoversOrdered = allMoversOrdered.substring(0, allMoversOrdered.length);

    final Email email = Email(
      body:
      'A client just placed an order using your app. \n Order details are as follows. \n User\'s email : ${user.email} \n Name of the movers : ${allMoversOrdered}\n Order amount : \$ ${widget.cartList.length * 5}\n',
      subject: 'New order',
      recipients: ['axactstudios@gmail.com'],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;
    print(platformResponse);
    Fluttertoast.showToast(
        msg: platformResponse, toastLength: Toast.LENGTH_SHORT);
  }

  void addOrders() async {
    String url = 'https://rocky-refuge-65574.herokuapp.com/api/orders/addOrder';

    FirebaseAuth mAuth = FirebaseAuth.instance;
    FirebaseUser user = await mAuth.currentUser();
    print(user.email);

    Map map = {
      'moversName': allMoversOrdered,
      'orderAmount': widget.cartList.length * 5,
      'email': user.email
    };

    await apiRequest(url, map).then((authResult) => print(authResult));
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    // ignore: close_sinks
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response =
    await request.close().timeout(Duration(seconds: 10));

    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);
    Fluttertoast.showToast(msg: reply, toastLength: Toast.LENGTH_SHORT);
  }
}
