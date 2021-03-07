import 'package:flutter/material.dart';
import 'package:ideabox/UI/widget/Idea.dart';
import 'package:responsive_grid/responsive_grid.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  bool like = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Idea Box', style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Icon(Icons.search, color: Colors.black), onPressed: null),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _drawerKey.currentState.openEndDrawer();
              },
              child: CircleAvatar(
                child: Text('AD', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.indigo,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(child: Text('IDEA BOX ')),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.home),
                  SizedBox(width: 20),
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              onTap: () {},
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.all_inclusive_rounded),
                  SizedBox(width: 20),
                  Text(
                    'Idea Box',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      endDrawer: Drawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveGridRow(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 13.0,
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
                          Row(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      'Explore',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: 3,
                                      width: 50,
                                      color: Colors.blue[300],
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'New',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Cate3',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: Container(
                      height: 100,
                      alignment: Alignment(0, 0),
                      color: Colors.orange,
                      child: Text("xs : 6 \r\nmd : 3"),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: Container(
                      height: 100,
                      alignment: Alignment(0, 0),
                      color: Colors.red,
                      child: Text("xs : 6 \r\nmd : 3"),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: Container(
                      height: 100,
                      alignment: Alignment(0, 0),
                      color: Colors.blue,
                      child: Text("xs : 6 \r\nmd : 3"),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: Container(
                      height: 100,
                      alignment: Alignment(0, 0),
                      color: Colors.green,
                      child: Text("xs : 6 \r\nmd : 3"),
                    ),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: Idea(),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: Idea(),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: Idea(),
                  ),
                  ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: Idea(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
