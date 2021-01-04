import 'dart:ui';

import 'package:acm_widget_mobile_app/settings/recipe_page_settings.dart';
import 'package:flutter/material.dart';

class RecipeSettings extends StatefulWidget {
  @override
  _RecipeSettingsState createState() => _RecipeSettingsState();
}

class _RecipeSettingsState extends State<RecipeSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Recipe Search Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          }
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text("Note: dairy, gluten, shellfish, soy, keto, and pescetarian filters are not available for normal search",
                style: TextStyle(
                  fontStyle: FontStyle.italic
                )
              ),
              SizedBox(height: 8),
              Text("Intolerances:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              SizedBox(height: 8),
              intoleranceSettings(),
              SizedBox(height: 8),
              Text("Diets:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              SizedBox(height: 8),
              dietSettings()
            ]
          )
        ),
      )
    );
  }

  Widget intoleranceSettings() {
    return Column(
      children: <Widget> [
        Container(
          child: CheckboxListTile(
            title: Text("Dairy Free"),
            value: Settings.searchSettings["dairy"],
            onChanged: (bool value) {
              setState(() {
                Settings.searchSettings["dairy"] = value;
              });
            }
          ),
        ),
        CheckboxListTile(
          title: Text("Gluten Free"),
          value: Settings.searchSettings["gluten"],
          onChanged: (bool value) {
            setState(() {
              Settings.searchSettings["gluten"] = value;
            });
          }
        ),
        CheckboxListTile(
          title: Text("Peanut Free"),
          value: Settings.searchSettings["peanut"],
          onChanged: (bool value) {
            setState(() {
              Settings.searchSettings["peanut"] = value;
            });
          }
        ),
        CheckboxListTile(
          title: Text("Shellfish Free"),
          value: Settings.searchSettings["shellfish"],
          onChanged: (bool value) {
            setState(() {
              Settings.searchSettings["dairy"] = value;
            });
          }
        ),
        CheckboxListTile(
          title: Text("Soy Free"),
          value: Settings.searchSettings["soy"],
          onChanged: (bool value) {
            setState(() {
              Settings.searchSettings["soy"] = value;
            });
          }
        ),
        CheckboxListTile(
          title: Text("Tree Nut Free"),
          value: Settings.searchSettings["tree nut"],
          onChanged: (bool value) {
            setState(() {
              Settings.searchSettings["tree nut"] = value;
            });
          }
        )
      ]
    );
  }

  Widget dietSettings() {
    return Column(
      children: <Widget> [
        CheckboxListTile(
          title: Text("Vegetarian"),
          value: Settings.searchSettings["vegetarian"],
          onChanged: (bool value) {
            setState(() {
              Settings.searchSettings["vegetarian"] = value;
            });
          }
        ),
        CheckboxListTile(
          title: Text("Vegan"),
          value: Settings.searchSettings["vegan"],
          onChanged: (bool value) {
            setState(() {
              Settings.searchSettings["vegan"] = value;
            });
          }
        ),
        CheckboxListTile(
          title: Text("Pescetarian"),
          value: Settings.searchSettings["pescetarian"],
          onChanged: (bool value) {
            setState(() {
              Settings.searchSettings["pescetarian"] = value;
            });
          }
        ),
        CheckboxListTile(
          title: Text("Ketogenic"),
          value: Settings.searchSettings["ketogenic"],
          onChanged: (bool value) {
            setState(() {
              Settings.searchSettings["ketogenic"] = value;
            });
          }
        ),
      ]
    );
  }
}
