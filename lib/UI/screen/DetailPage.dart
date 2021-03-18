import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ideabox/UI/widget/AppBar.dart';
import 'package:ideabox/UI/widget/NavigationDrawer.dart';
import 'package:http/http.dart' as http;

import '../../Constent.dart';

class DetailPage extends StatefulWidget {
  final BuildContext context;
  final int id;

  const DetailPage({Key key, this.context, this.id}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var idea;
  String title = "";
  String description = "";

  getData() async {
    Uri url = Uri.http(Constants.url, "/ideas/" + widget.id.toString() + "/");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var collection = json.decode(response.body);

      setState(() {
        idea = collection;
        title = idea['title'];
        description = idea['description'];
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarIdea(menu: false, contextHome: context),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "https://source.unsplash.com/random",
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                return progress == null ? child : LinearProgressIndicator();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700]),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 10, right: 40),
                child: Text(
                  description,
                  style: TextStyle(color: Colors.grey[500]),
                ))
          ],
        ),
      ),
    );
  }
}
