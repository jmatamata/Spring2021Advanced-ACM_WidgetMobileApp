import 'package:flutter/material.dart';
import 'package:acm_widget_mobile_app/data/global_data.dart';

class Settings {
  // keeps track of if the search bar is in normal or reverse mode
  static bool isSearchBarNormal = true;

  // controllers for the text field/search bars
  static final normalController = TextEditingController();
  static final reverseController = TextEditingController();

  // https://developer.edamam.com/edamam-docs-recipe-api
  // https://spoonacular.com/food-api/console#Dashboard

  // put your keys in the data/global_data.dart file
  static String edamamAPIKey = GlobalData.edamamAPIKey;
  static String edamamAPIAppID = GlobalData.edamamAPIAppID;
  static String spoonacularAPIKey = GlobalData.spoonacularAPIKey;

  // main link of the API
  static String edamamAPI = "https://api.edamam.com/search?q=";
  // keys from the API
  static String edamamKeys = "&app_id=$edamamAPIAppID&app_key=$edamamAPIKey";
  // restrict to only 15 recipes and 15 ingredients max
  static String edamamDefaultSettings = "&to=15&ingr=15";

  // main link of the API
  static String spoonacularAPI =
      "https://api.spoonacular.com/recipes/complexSearch?includeIngredients=";
  // key from the API and default settings, 15 recipes max
  static String spoonacularDefaultSettings =
      "&number=15&addRecipeInformation=true&apiKey=$spoonacularAPIKey";

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
    if (searchSettings["dairy"]) {
      //extraEdamamSettings += "&health=dairy-free";
      spoonacularIntolerances.add("dairy");
    }
    if (searchSettings["gluten"]) {
      //extraEdamamSettings += "&health=gluten-free";
      spoonacularIntolerances.add("gluten");
    }
    if (searchSettings["peanut"]) {
      extraEdamamSettings += "&health=peanut-free";
      spoonacularIntolerances.add("peanut");
    }
    if (searchSettings["shellfish"]) {
      //extraEdamamSettings += "&health=shellfish-free";
      spoonacularIntolerances.add("shellfish");
    }
    if (searchSettings["soy"]) {
      //extraEdamamSettings += "health=&soy-free";
      spoonacularIntolerances.add("soy");
    }
    if (searchSettings["tree nut"]) {
      extraEdamamSettings += "&health=tree-nut-free";
      spoonacularIntolerances.add("tree nut");
    }

    if (searchSettings["vegetarian"]) {
      extraEdamamSettings += "&health=vegetarian";
      spoonacularDiets.add("vegetarian");
    }
    if (searchSettings["vegan"]) {
      extraEdamamSettings += "&health=vegan";
      spoonacularDiets.add("vegan");
    }
    if (searchSettings["ketogenic"]) {
      //extraEdamamSettings += "&health=keto-friendly";
      spoonacularDiets.add("ketogenic");
    }
    if (searchSettings["pescetarian"]) {
      //extraEdamamSettings += "&health=pescetarian";
      spoonacularDiets.add("pescetarian");
    }

    // set the spoonacular settings as required by the API; the edamam settings are already set
    extraSpoonacularSettings =
        "&intolerances=${spoonacularIntolerances.join(",")}&diet=${spoonacularDiets.join(",")}";
  }
}
