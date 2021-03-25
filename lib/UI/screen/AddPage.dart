import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideabox/UI/widget/AppBar.dart';
import 'package:ideabox/UI/widget/NavigationDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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

  File _image;
  final picker = ImagePicker();

  Future getImage({String from}) async {
    //Example for GetX to Close the Dialog box
    Get.back();

    final pickedFile = await picker.getImage(
        source: from == "camera" ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  showModal() {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          child: ListView(
            children: [
              ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('From Camera'),
                  onTap: () => getImage(from: "camera")),
              ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('From Galery'),
                  onTap: () => getImage(from: "galery")),
            ],
          ),
        );
      },
    );
  }

  saveFrom() async {
    if (_formKey.currentState.validate()) {
      Uri url = Uri.http(Constants.url, "/idea/");

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
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Positioned(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: _image != null
                            ? Image.file(
                                _image,
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 2,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                'https://aeroclub-issoire.fr/wp-content/uploads/2020/05/image-not-found.jpg',
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 2,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          padding: EdgeInsets.all(40),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                },
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      right: -15,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.grey[300], width: 0.5),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.indigo[300],
                          child: IconButton(
                            icon: Icon(
                              Icons.photo_camera_outlined,
                              color: Colors.white,
                            ),
                            onPressed: showModal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
