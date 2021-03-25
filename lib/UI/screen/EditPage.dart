import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ideabox/UI/widget/AppBar.dart';
import 'package:ideabox/UI/widget/NavigationDrawer.dart';
import 'package:http/http.dart' as http;

import '../../Constent.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key key, this.id}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();

  final int id;
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  var idea;
  String getTitle = "";
  String getDescription = "";

  TextEditingController controllerTitle;
  TextEditingController controllerDesciption;

  getData() async {
    Uri url = Uri.http(Constants.url, "/idea/" + widget.id.toString() + "/");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var collection = json.decode(response.body);

      setState(() {
        idea = collection;
        getTitle = idea['title'];
        getDescription = idea['description'];

        title = idea['title'];
        description = idea['description'];

        controllerDesciption = TextEditingController(text: getDescription);
        controllerTitle = TextEditingController(text: getTitle);

        print(getTitle);
        print(getDescription);
      });
    }
  }

  String title = "";
  String description = "";
  saveFrom() async {
    if (_formKey.currentState.validate()) {
      Uri url = Uri.http(Constants.url, "/idea/" + widget.id.toString() + "/");

      final response = await http.put(
        url,
        body: jsonEncode(<String, String>{
          'title': title,
          'description': description,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
      }

      _drawerKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.yellow[600],
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.black),
            Text(
              "Idea is successfully modified",
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
      ));
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
      key: _drawerKey,
      backgroundColor: Colors.white,
      appBar: AppBarIdea(menu: false, contextHome: context),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  'EDIT IDEA',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.all(3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "https://source.unsplash.com/random",
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 2,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        return progress == null
                            ? child
                            : Container(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 2,
                                padding: EdgeInsets.all(40),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: controllerTitle,
                    onSaved: (val) => setState(() => title = val),
                    onChanged: (val) => setState(() => title = val),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please enter some Text";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.title),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: controllerDesciption,
                    onSaved: (val) => setState(() => {description = val}),
                    onChanged: (val) => setState(() => description = val),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please enter some Text";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.description),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: saveFrom,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      padding: MaterialStateProperty.all(EdgeInsets.only(
                          left: 60, right: 60, top: 10, bottom: 10)),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 15, color: Colors.white))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
