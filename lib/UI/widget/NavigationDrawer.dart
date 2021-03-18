import 'package:flutter/material.dart';

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
    );
  }
}
