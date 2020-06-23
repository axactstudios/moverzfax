import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:moverzfax/Classes/mover.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Search());
  }
}

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController editingController = TextEditingController();

  List<String> duplicateItems;
  var items = List<String>();

  @override
  void initState() {
    fetchData();
    duplicateItems =
        List<String>.generate(data.length, (i) => data[i].moverName);
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
        print(items[0]);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  bool isLoaded = false;
  List<Mover> data = new List();

  List<Mover> parseMovers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Mover>((json) => Mover.fromJson(json)).toList();
  }

  fetchData() async {
    if (isLoaded == false) {
      var response = await http.get('http://localhost:27017/movers/listall');
      setState(() {
        data = parseMovers(response.body);
        isLoaded = true;
        print(data.length.toString());
      });
    }
    List<String> temp = new List();
    for (int i = 0; i < data.length; i++) {
      temp.add(data[i].moverName);
    }
    duplicateItems = temp;
  }

  @override
  Widget build(BuildContext context) {
    fetchData();

    return new Scaffold(
      appBar: GFAppBar(
        backgroundColor: Color(0xFF3871AD),
        title: Text(
          "MoverZfax",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'nunito',
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  print(items[0]);
                  Mover temp;
                  for (int i = 0; i < data.length; i++) {
                    if (data[i].moverName == items[index]) {
                      temp = data[i];
                    }
                  }
                  return InkWell(
                    onTap: () {},
                    child: Padding(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 45,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                child: Text(
                                  temp.moverName,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'PhNo- ${temp.moverPhno}',
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'nunito',
                                            fontSize: 14),
                                        overflow: TextOverflow.fade,
                                      ),
                                      Text(
                                        'Rating- ${temp.moverRating}',
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'nunito',
                                            fontSize: 14),
                                        overflow: TextOverflow.fade,
                                      ),
                                      Text(
                                        'USDOT No- ${temp.moverUSDOTNo}',
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'nunito',
                                            fontSize: 14),
                                        overflow: TextOverflow.fade,
                                      ),
                                      Text(
                                        'MC No- ${temp.moverMCNo}',
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
                                          'Description- ${temp.moverDescription}',
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
