import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ideabox/UI/screen/DetailPage.dart';
import 'package:http/http.dart' as http;
import 'package:ideabox/UI/screen/EditPage.dart';

import '../../Constent.dart';

class Idea extends StatefulWidget {
  const Idea({Key key, this.id, this.title, this.description, this.drawerKey})
      : super(key: key);

  @override
  _IdeaState createState() => _IdeaState();

  final int id;
  final String title;
  final String description;
  final GlobalKey<ScaffoldState> drawerKey;
}

class _IdeaState extends State<Idea> {
  bool like = false;
  bool delete = false;

  deleteIdea() async {
    widget.drawerKey
      ..currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.yellow[600],
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.black),
            Text(
              widget.title + " successfully delete",
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
      ));

    Uri url = Uri.http(Constants.url, "/ideas/" + widget.id.toString() + "/");
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(id: widget.id),
          ),
        );
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment(0, 0),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(9),
                      topLeft: Radius.circular(9),
                    ),
                    child: Image.network(
                      'https://source.unsplash.com/random',
                      height: MediaQuery.of(context).size.height / 4.5,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height / 4.5,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(40),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              '94 ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.remove_red_eye_outlined,
                              size: 16,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.description,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          padding: EdgeInsets.all(0),
                          icon: like
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border),
                          onPressed: () {
                            setState(() {
                              like = !like;
                            });
                          }),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.all(0),
                            alignment: Alignment.centerRight,
                            icon: Icon(Icons.edit, color: Colors.yellow[700]),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPage(id: widget.id),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(Icons.delete, color: Colors.red[700]),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text(
                                          'Would you like to delete this Idea'),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text('Cancel'),
                                        ),
                                        CupertinoDialogAction(
                                          child: Text("Delete"),
                                          onPressed: () {
                                            deleteIdea();
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            enableFeedback: false,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
