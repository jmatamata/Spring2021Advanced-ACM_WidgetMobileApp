import 'package:flutter/material.dart';

class Settings {
  // keeps track of if the search bar is in normal or reverse mode
  static bool isSearchBarNormal = true;

  // controllers for the text field/search bars
  static final normalController = TextEditingController();
  static final reverseController = TextEditingController();

  // main link of the API
  static String edamamAPI = "https://api.edamam.com/search?q=";
  // keys from the API
  static String edamamKeys = "&app_id=73ad97b0&app_key=fcc6392d4f6b8e5415babcd2e8b6522f";
  // restrict to only 15 recipes and 15 ingredients max
  static String edamamDefaultSettings = "&to=15&ingr=15";

  // main link of the API
  static String spoonacularAPI = "https://api.spoonacular.com/recipes/complexSearch?includeIngredients=";
  // key from the API and default settings, 15 recipes max
  static String spoonacularDefaultSettings = "&number=15&addRecipeInformation=true&apiKey=c19807aac0624e69a7ab5139015c2697";

  // parsed json returned from the API
  static Map edamamReturned;

  static Map spoonacularReturned;

  static Map<String, bool> searchSettings = {
    "dairy": false,
    "gluten": false,
    "peanut": false,
    "shellfish": false,
    "soy": false,
    "tree nut": false,
    "vegetarian": false,
    "vegan": false,
    "pescetarian": false,
    "ketogenic": false
  };

  static String extraEdamamSettings = "";
  static String extraSpoonacularSettings = "";

  static void updateSettings() {
    extraEdamamSettings = "";
    extraSpoonacularSettings = "";

    List spoonacularIntolerances = [];
    List spoonacularDiets = [];

    // Note: dairy, gluten, shellfish, soy, keto, and pescetarian filters are not available for normal search
    if(searchSettings["dairy"]) {
      //extraEdamamSettings += "&health=dairy-free";
      spoonacularIntolerances.add("dairy");
    }
    if(searchSettings["gluten"]) {
      //extraEdamamSettings += "&health=gluten-free";
      spoonacularIntolerances.add("gluten");
    }
    if(searchSettings["peanut"]) {
      extraEdamamSettings += "&health=peanut-free";
      spoonacularIntolerances.add("peanut");
    }
    if(searchSettings["shellfish"]) {
      //extraEdamamSettings += "&health=shellfish-free";
      spoonacularIntolerances.add("shellfish");
    }
    if(searchSettings["soy"]) {
      //extraEdamamSettings += "health=&soy-free";
      spoonacularIntolerances.add("soy");
    }
    if(searchSettings["tree nut"]) {
      extraEdamamSettings += "&health=tree-nut-free";
      spoonacularIntolerances.add("tree nut");
    }

    if(searchSettings["vegetarian"]) {
      extraEdamamSettings += "&health=vegetarian";
      spoonacularDiets.add("vegetarian");
    }
    if(searchSettings["vegan"]) {
      extraEdamamSettings += "&health=vegan";
      spoonacularDiets.add("vegan");
    }
    if(searchSettings["ketogenic"]) {
      //extraEdamamSettings += "&health=keto-friendly";
      spoonacularDiets.add("ketogenic");
    }
    if(searchSettings["pescetarian"]) {
      //extraEdamamSettings += "&health=pescetarian";
      spoonacularDiets.add("pescetarian");
    }

    // set the spoonacular settings as required by the API; the edamam settings are already set
    extraSpoonacularSettings = "&intolerances=${spoonacularIntolerances.join(",")}&diet=${spoonacularDiets.join(",")}";
  }
}