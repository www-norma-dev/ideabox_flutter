import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ideabox/UI/screen/AddPage.dart';
import 'package:ideabox/UI/widget/AppBar.dart';
import 'package:ideabox/UI/widget/Idea.dart';
import 'package:ideabox/UI/widget/NavigationDrawer.dart';
import 'package:ideabox/UI/widget/Tags.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:http/http.dart' as http;

import '../../Constent.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  bool like = false;

  List ideaList = [];
  List<ResponsiveGridCol> ideas = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  getData() async {
    Uri url = Uri.http(Constants.url, "/ideas/");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var collection = json.decode(response.body);

      setState(() {
        ideaList.clear();
        ideas.clear();
        ideaList = collection;
        insetDataInResponsiveGrid();
      });
    }
  }

  getDataSearch(query) async {
    Uri url = Uri.http(Constants.url, "/ideas/");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var collection = json.decode(response.body);

      setState(() {
        ideaList.clear();
        ideas.clear();
        ideaList = collection;
        ideaList = ideaList
            .where((e) =>
                e["title"].toLowerCase().contains(query) ||
                e["description"].toLowerCase().contains(query))
            .toList();
        insetDataInResponsiveGrid();
      });
    }
  }

  insetDataInResponsiveGrid() {
    for (var i = 0; i < ideaList.length; i++) {
      ideas.add(ResponsiveGridCol(
        xs: 6,
        md: 3,
        child: Idea(
          id: ideaList[i]["id"],
          title: ideaList[i]["title"],
          description: ideaList[i]["description"],
          drawerKey: _drawerKey,
        ),
      ));
    }
  }

  onChangeTextFiel(value) {
    getDataSearch(value);
    print(value);
  }

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    await getData();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: AppBarIdea(
        onTap: () {
          _drawerKey.currentState.openEndDrawer();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
        },
      ),
      drawer: NavigationDrawer(),
      endDrawer: Drawer(),
      backgroundColor: Colors.white,
      body: SmartRefresher(
        onRefresh: _onRefresh,
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        child: Scrollbar(
          radius: Radius.circular(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(
                        lg: 12,
                        child: Container(
                          alignment: Alignment(-1, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30),
                              Text(
                                "Everything begins \nwith an idea",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 30),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: TextField(
                                  onChanged: onChangeTextFiel,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    height: 1.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Title, Category...",
                                    prefixIcon: SizedBox(width: 10),
                                    suffixIcon:
                                        Icon(Icons.search, color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Tags()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridRow(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ideas,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
