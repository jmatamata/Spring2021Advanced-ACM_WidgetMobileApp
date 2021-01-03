import 'dart:convert';
import 'package:acm_widget_mobile_app/data/global_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'models/weather_locations.dart';
import 'widgets/building_transform.dart';
import 'widgets/single_weather.dart';
import 'widgets/slider_dot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  int _currentPage = 0;
  List _locationList;
  String bgImg;

  initState(){
    super.initState();
    _getWeather();
  }
  _onPageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Future _getWeather() async{
    List list = [];
    //Los Angeles: 5368361
    //Mexico City: 3530597
    //London: 2643743
    //Paris: 2968815
    //New Delhi: 1261481
    //Cairo: 360630
    String cities = '5368361,3530597,2643743,2968815,1261481,360630';
    Response response = await get('https://api.openweathermap.org/data/2.5/group?id=$cities&appid=${GlobalData.owaKey}&units=imperial');
    var decodedJson = json.decode(response.body);
    var citiesList = decodedJson['list'];
    for(int i = 0; i < citiesList.length; i++){
      var city = citiesList[i];
      list.add(new WeatherLocation(city: city['name'], temperature: city['main']['temp'].toStringAsFixed(0), weatherType: city['weather'][0]['main'], weatherDesc: city['weather'][0]['description'], wind: city['wind']['speed'], pressure: city['main']['pressure'].round(), humidity: city['main']['humidity'].round()));
    }
    setState(() {
      _locationList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    String mainWeather;
    Widget spinner;

    if(_locationList == null){
      mainWeather = 'unknown';
      spinner = Center(
        child: SpinKitCircle(
          color: Colors.grey,
          size: 50.0,
        )
      );
    }
    else{
      mainWeather = _locationList[_currentPage].weatherType.toLowerCase();
      spinner = SizedBox(height: 0);
    }

    //sun
    if(mainWeather.contains('sun') || mainWeather.contains('sunny') || mainWeather.contains('clear') || mainWeather.contains('hot')) {
      bgImg = 'assets/sunny.jpg';
    }
    //night
    else if(mainWeather.contains('night') || mainWeather.contains('clear night') || mainWeather.contains('moon') || mainWeather.contains('clear night')) {
      bgImg = 'assets/night.jpg';
    }
    //rain
    else if(mainWeather.contains('rain') || mainWeather.contains('rainy') || mainWeather.contains('thunder') || mainWeather.contains('downfall')) {
      bgImg = 'assets/rainy.jpg';
    }
    //clouds
    else if(mainWeather.contains('overcast') || mainWeather.contains('fog') || mainWeather.contains('cloudy') || mainWeather.contains('clouds')) {
      bgImg = 'assets/cloudy.jpg';
    }
    //snow
    else if(mainWeather.contains('snow') || mainWeather.contains('snowy') || mainWeather.contains('blizzard') || mainWeather.contains('snowfall')){
      bgImg = 'assets/snowy.jpg';
    }
    //extreme
    else if(mainWeather.contains('severe') || mainWeather.contains('hurricane') || mainWeather.contains('tornado') || mainWeather.contains('extreme')){
        bgImg = 'assets/extreme.png';
    }
    //unknown
    else{
        bgImg = 'assets/unknown.jpg';
    }

    String date = DateFormat('MM-dd-yyyy KK:mm a').format(DateTime.now()).toString();

    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Image.asset(
            bgImg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black38),
          ),
          Container(
              child: spinner
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
          margin: EdgeInsets.only(top: 140, left: 15),
                child: Row(
                  children: [
                    for (int i = 0; i < (_locationList == null ? 0 : _locationList.length); i++)
                      if (i == _currentPage) SliderDot(true) else SliderDot(false)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 130, left: 55),
                child: _locationList == null ?  Text('') : Text(date, style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                )),
              ),
            ],
          ),
          TransformerPageView(
            transformer: ScaleAndFadeTransformer(),
              viewportFraction: 0.8,
              onPageChanged: _onPageChange,
              scrollDirection: Axis.horizontal,
              itemCount: _locationList == null ? 0 : _locationList.length,
              itemBuilder: (ctx, i) => SingleWeather(_locationList[i])),
        ],
      ),
    ));
  }
}
