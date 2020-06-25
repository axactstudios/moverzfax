import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                    onPressed: () {},
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
}
