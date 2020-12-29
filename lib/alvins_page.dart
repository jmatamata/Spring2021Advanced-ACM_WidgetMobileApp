import 'package:flutter/material.dart';

class AlvinsPage extends StatefulWidget {
  @override
  _AlvinsPageState createState() => _AlvinsPageState();
}

class _AlvinsPageState extends State<AlvinsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            //margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                )
            ),
            child: SearchBar()
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: <Widget>[
                recipeTemplate(),
                recipeTemplate(),
                recipeTemplate()
              ],
            )
          )
        )
      ],
    );
  }

  Widget recipeTemplate() {
    return Card(
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Recipe:"),
            Text("- cool ingredient 1"),
            Text("- cool ingredient 2"),
            Text("- cool ingredient 3")
          ]
        ),
      )
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Color normalButtonColor = Colors.amber;
  Color reverseButtonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    if(Settings.isSearchBarNormal) {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                  onPressed: () {},
                  color: Colors.blue,
                  padding: EdgeInsets.all(8),
                  elevation: 2.0,
                  child: Icon(Icons.settings, color: Colors.white),
                  shape: CircleBorder()
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          Settings.isSearchBarNormal = true;
                          normalButtonColor = Colors.amber;
                          reverseButtonColor = Colors.white;
                        });
                      },
                      color: normalButtonColor,
                      child: Text("Normal"),
                    ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          Settings.isSearchBarNormal = false;
                          normalButtonColor = Colors.white;
                          reverseButtonColor = Colors.amber;
                        });
                      },
                      color: reverseButtonColor,
                      child: Text("Reverse"),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
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
            padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
            child: TextField(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                  onPressed: () {},
                  color: Colors.blue,
                  padding: EdgeInsets.all(8),
                  elevation: 2.0,
                  child: Icon(Icons.settings, color: Colors.white),
                  shape: CircleBorder()
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          Settings.isSearchBarNormal = true;
                          normalButtonColor = Colors.amber;
                          reverseButtonColor = Colors.white;
                        });
                      },
                      color: normalButtonColor,
                      child: Text("Normal"),
                    ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          Settings.isSearchBarNormal = false;
                          normalButtonColor = Colors.white;
                          reverseButtonColor = Colors.amber;
                        });
                      },
                      color: reverseButtonColor,
                      child: Text("Reverse"),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
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
            padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter ingredient names",
              )
            ),
          )
        ],
      );
    }
  }
}

class Settings {
  static bool isSearchBarNormal = true;
}