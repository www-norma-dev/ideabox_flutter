import 'package:flutter/material.dart';

class AppBarIdea extends StatelessWidget implements PreferredSizeWidget {
  final Function onTap;
  final bool menu;
  final BuildContext contextHome;

  const AppBarIdea({this.onTap, this.menu = true, this.contextHome});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text('Idea Box', style: TextStyle(color: Colors.black)),
      elevation: 0,
      leading: !menu
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(this.contextHome);
              },
            )
          : null,
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            icon: Icon(Icons.search, color: Colors.black), onPressed: null),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              child: Text('AD', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.indigo,
            ),
          ),
        ),
      ],
    );
  }
}
