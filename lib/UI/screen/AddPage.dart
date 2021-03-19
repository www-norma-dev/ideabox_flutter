import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ideabox/UI/widget/AppBar.dart';
import 'package:ideabox/UI/widget/NavigationDrawer.dart';
import 'package:http/http.dart' as http;

import '../../Constent.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  String title = "";
  String description = "";
  saveFrom() async {
    if (_formKey.currentState.validate()) {
      Uri url = Uri.http(Constants.url, "/ideas/");

      final response = await http.post(
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
              "   Idea successfully added",
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
      ));
    }
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
                SizedBox(height: 60),
                Text(
                  'ADD NEW IDEA',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    onChanged: (val) => setState(() => title = val),
                    onSaved: (val) => setState(() => title = val),
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
                    onChanged: (val) => setState(() => description = val),
                    onSaved: (val) => setState(() => description = val),
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
