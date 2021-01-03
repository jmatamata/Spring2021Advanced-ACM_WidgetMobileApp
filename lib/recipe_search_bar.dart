import 'package:flutter/material.dart';
import 'package:acm_widget_mobile_app/recipe_page_settings.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    if(Settings.isSearchBarNormal) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 16, 0, 0),
            child: Row(
              children: <Widget>[
                Icon(Icons.search),
                SizedBox(width: 10),
                Text(
                  "Normal Recipe Search",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: TextField(
              controller: Settings.normalController,
              decoration: InputDecoration(
                hintText: "Enter recipe name",
              )
            ),
          )
        ],
      );
    }
    else {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 16, 0, 0),
            child: Row(
              children: <Widget>[
                Icon(Icons.search),
                SizedBox(width: 10),
                Text(
                  "Reverse Recipe Search",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(40, 7, 40, 0),
            child: TextField(
              controller: Settings.reverseController,
              decoration: InputDecoration(
                hintText: "Enter comma-separated ingredient names",
              )
            ),
          ),
        ],
      );
    }
  }
}
