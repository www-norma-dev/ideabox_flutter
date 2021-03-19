import 'package:flutter/material.dart';
import 'package:ideabox/UI/screen/AddPage.dart';
import 'package:ideabox/UI/screen/HomePage.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.add,
                ),
                SizedBox(width: 20),
                Text(
                  'ADD NEW IDEA',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
