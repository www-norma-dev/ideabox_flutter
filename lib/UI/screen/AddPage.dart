import 'dart:convert';

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

  String title;
  String description;
  saveFrom() async {
    if (_formKey.currentState.validate()) {}

    Uri url = Uri.http(Constants.url, "/ideas/");

    var data = {title: title, description: description};
    // var headers = {Content-Type:  application/json};

    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarIdea(menu: false, contextHome: context),
      drawer: NavigationDrawer(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please enter some Text";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                  initialValue: 'Input text',
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
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please enter some Text";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    setState(() {
                      description = val;
                    });
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
    );
  }
}
