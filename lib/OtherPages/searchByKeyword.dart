import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:moverzfax/Classes/mover.dart';
import 'package:moverzfax/OtherPages/moverDetailsPullUp.dart';

class SearchByKeyword extends StatelessWidget {
  // This widget is the root of your application.
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

double width, height;

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
      var response = await http
          .get('https://whispering-meadow-64251.herokuapp.com/movers/listall');
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

  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    fetchData();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return new Scaffold(
      key: scaffoldState,
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
                  print(items.length.toString());
                  return InkWell(
                    onTap: () {
                      Mover temp;
                      for (int i = 0; i < data.length; i++) {
                        if (data[i].moverName == items[index]) {
                          temp = data[i];
                        }
                      }
                      scaffoldState.currentState.showBottomSheet((context) {
                        return StatefulBuilder(
                            builder: (BuildContext context, StateSetter state) {
                          return MoverDetailsPullUp(
                              context: context,
                              height: height,
                              width: width,
                              mover: temp);
                        });
                      });
                    },
                    child: ListTile(
                      title: Text(items[index]),
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
