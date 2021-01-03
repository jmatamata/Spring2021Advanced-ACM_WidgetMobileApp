import 'package:acm_widget_mobile_app/settings/recipe_page_settings.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    if (Settings.isSearchBarNormal) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 16, 0, 0),
            child: Row(
              children: <Widget>[
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 10),
                Text("Normal Recipe Search",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: TextField(
                controller: Settings.normalController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                    color: Colors.white
                  )),
                    hintText: "Enter recipe name",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white)),
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 16, 0, 0),
            child: Row(
              children: <Widget>[
                Icon(Icons.search, color: Colors.white,),
                SizedBox(width: 10),
                Text("Reverse Recipe Search",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: TextField(
                controller: Settings.reverseController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.white
                  )),
                  hintText: "Enter comma-separated ingredients",
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                )),
          ),
        ],
      );
    }
  }
}
