import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Idea extends StatefulWidget {
  @override
  _IdeaState createState() => _IdeaState();
}

class _IdeaState extends State<Idea> {
  bool like = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                Container(
                  child: Image.network('https://source.unsplash.com/random'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                  child: Text(
                    'Title Here',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtitles Here',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w300),
                      ),
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
                IconButton(
                    padding: EdgeInsets.all(0),
                    icon: like
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        like = !like;
                      });
                    })
              ],
            ),
          ),
        ));
  }
}
