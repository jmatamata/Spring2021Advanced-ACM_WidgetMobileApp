import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:acm_widget_mobile_app/recipe_search_bar.dart';
import 'package:acm_widget_mobile_app/recipe_page_settings.dart';
import 'package:acm_widget_mobile_app/recipe_search_settings.dart';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  Color highlightedColor = Color.fromRGBO(255, 230, 36, 1);
  Color normalButtonColor = Color.fromRGBO(255, 230, 36, 1);
  Color reverseButtonColor = Colors.white;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Stack(
            children: <Widget> [
              // the positioned are circles to create layers in the background
              Positioned(
                bottom: 20,
                right: 125,
                child: Container(
                  height: 400, 
                  width: 400, 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: Color.fromRGBO(191, 255, 192, 0.8)
                  ),
                )
              ),
              Positioned(
                bottom: 150,
                left: 150,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    color: Color.fromRGBO(163, 255, 165, 0.65)
                  ),
                )
              ),
              Positioned(
                top: 80,
                left: 200,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(125),
                    color: Color.fromRGBO(107, 250, 100, 0.3)
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(99, 255, 101, 0.6),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                    )
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MaterialButton(
                            onPressed: () async {
                                // when the settings button is pressed, have a new screen ready
                                await Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => RecipeSettings()
                                ));

                                // update settings after user comes back to this page
                                Settings.updateSettings();
                            },
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
                                    normalButtonColor = highlightedColor;
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
                                    reverseButtonColor = highlightedColor;
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
                    SearchBar(), // this is the search bar that will depend on the normal/reverse setting
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(40, 15, 0, 0),
                          child: RaisedButton(
                            onPressed: () async {
                              var currentFocus = FocusScope.of(context);
                              if(!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              setState(() {
                                isLoading = true;
                              });

                              if(Settings.isSearchBarNormal) {
                                await getData(Settings.normalController.text);
                              }
                              else {
                                await getData(Settings.reverseController.text);
                              }

                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: Text("Search"),
                            color: Colors.lightBlue
                          ),
                        )
                      ]
                    )
                  ],
                )
              ),
            ]
          ),
        ),
        Expanded(
          flex: 3,
          child: processRecipesWithLoading()
        )
      ],
    );
  }

  Widget processRecipesWithLoading() {
    if(isLoading) {
      return Center(
        child: SpinKitCircle(
          color: Colors.grey,
          size: 50.0,
        )
      );
    }
    else {
      return processRecipes();
    }
  }

  Future<void> getData(String searchQuery) async {
    String request;
    // parse the search query into the correct format for the API
    if(Settings.isSearchBarNormal) {
      request = Settings.edamamAPI + searchQuery + Settings.edamamKeys + Settings.extraEdamamSettings;
    }
    else {
      request = Settings.spoonacularAPI + searchQuery + Settings.spoonacularDefaultSettings + Settings.extraSpoonacularSettings;
    }

    // fetch data from the API
    try {
      Response res = await get(request);
      Map data = jsonDecode(res.body);

      if(Settings.isSearchBarNormal) {
        Settings.edamamReturned = data;
      }
      else {
        Settings.spoonacularReturned = data;
      }
    }
    catch (e) {
      print(e);
    }
  }
  
  Widget processRecipes() {
    if(Settings.isSearchBarNormal) {
      if (Settings.edamamReturned == null) {
        return Container(
            padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
            child: Text("recipes will appear here!",
                style: TextStyle(
                    color: Colors.grey[400]
                )
            )
        );
      }

      List<Widget> recipeWidgets = [];
      int recipes = Settings.edamamReturned["hits"].length;

      // if there are no results from the API
      if (recipes == 0) {
        return Container(
          padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
          child: Text("No results found :( try widening your search!",
              style: TextStyle(
                  color: Colors.grey[500]
              )
          ),
        );
      }

      for (int i = 0; i < recipes; i++) {
        recipeWidgets.add(edamamRecipeTemplate(i));
      }

      // return a scrollable view of all 10 recipes
      return SingleChildScrollView(
          child: Column(
              children: recipeWidgets
          )
      );
    }
    else {
      if (Settings.spoonacularReturned == null) {
        return Container(
            padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
            child: Text("recipes will appear here!",
                style: TextStyle(
                    color: Colors.grey[400]
                )
            )
        );
      }

      List<Widget> recipeWidgets = [];
      int recipes = Settings.spoonacularReturned["results"].length;

      // if there are no results from the API
      if (recipes == 0) {
        return Container(
          padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
          child: Text("No results found :( try widening your search!",
              style: TextStyle(
                  color: Colors.grey[500]
              )
          ),
        );
      }

      for (int i = 0; i < recipes; i++) {
        recipeWidgets.add(spoonacularRecipeTemplate(i));
      }

      if(recipeWidgets != null) {
        // return a scrollable view of all 10 recipes
        return SingleChildScrollView(
            child: Column(
                children: recipeWidgets
            )
        );
      }
      else {
        return Container(
          padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
          child: Text("No results found :( try widening your search!",
              style: TextStyle(
                  color: Colors.grey[500]
              )
          ),
        );
      }
    }
  }

  Widget edamamRecipeTemplate(int i) {
    if(Settings.edamamReturned.isNotEmpty) {
      // get the map containing the information of the recipe that we're on
      Map recipeInfo = Settings.edamamReturned["hits"][i]["recipe"];

      // turn the list of ingredients into a string
      String ingredientStr = recipeInfo["ingredientLines"].join("\n");

      // if the recipe label is too long, shrink its size
      double labelSize = (recipeInfo["label"].toString().length <= 40) ? 20 : 18;

      return Card(
        margin: EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Padding (
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(recipeInfo["image"]),
                    radius: 35
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(recipeInfo["label"],
                      style: TextStyle(
                        fontSize: labelSize,
                        letterSpacing: 0.5
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Ingredients:",
                    style: TextStyle(
                      fontSize: 16
                    )
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(ingredientStr),
              SizedBox(height: 10),
              Text("Full recipe link:",
                style: TextStyle(fontSize: 12)
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                  text: recipeInfo["url"],
                  recognizer: TapGestureRecognizer()..onTap = () async {
                    if(await canLaunch(recipeInfo["url"])) {
                      await launch(recipeInfo["url"]);
                    }
                    else {
                      throw "Cannot launch URL";
                    }
                  }
                )
              )
            ],
          ),
        )
      );
    }

    return SizedBox(height: 0);
  }

  Widget spoonacularRecipeTemplate(int i) {
    if(Settings.spoonacularReturned.isNotEmpty) {
      // get the map containing the information of the recipe that we're on
      Map recipeInfo = Settings.spoonacularReturned["results"][i];
      String ingredientStr = "";

      if(recipeInfo["analyzedInstructions"].length > 0) {
        // we have to manually parse the ingredients from this API
        List<String> ingredients = [];

        if(recipeInfo["analyzedInstructions"].length == 0) return null;
        List steps = recipeInfo["analyzedInstructions"][0]["steps"];

        for(int i = 0; i < steps.length; i++) {
          List currentIngredients = steps[i]["ingredients"];

          // take the ingredient name from each of these
          for(int j = 0; j < currentIngredients.length; j++) {
            ingredients.add(currentIngredients[j]["name"]);
          }
        }

        // turn the list of distinct ingredients into a string
        List<String> distinctIngredients = ingredients.toSet().toList();
        ingredientStr = distinctIngredients.join("\n");
      }
      else {
        ingredientStr = "Ingredient information not found. Please check the website for more details!";
      }

      // if the recipe label is too long, shrink its size
      double labelSize = (recipeInfo["title"].toString().length <= 40) ? 20 : 18;

      return Card(
        margin: EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Padding (
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(recipeInfo["image"]),
                    radius: 35
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(recipeInfo["title"],
                      style: TextStyle(
                        fontSize: labelSize,
                        letterSpacing: 0.5
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Ingredients:",
                    style: TextStyle(
                      fontSize: 16
                    )
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(ingredientStr),
              SizedBox(height: 10),
              Text("Full recipe link:",
                style: TextStyle(fontSize: 12)
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                  text: recipeInfo["sourceUrl"],
                  recognizer: TapGestureRecognizer()..onTap = () async {
                    if(await canLaunch(recipeInfo["sourceUrl"])) {
                      await launch(recipeInfo["sourceUrl"]);
                    }
                    else {
                      throw "Cannot launch URL";
                    }
                  }
                )
              )
            ],
          ),
        )
      );
    }

    return SizedBox(height: 0);
  }
}
