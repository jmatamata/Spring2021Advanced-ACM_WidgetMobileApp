import 'package:flutter/material.dart';

class WeatherLocation {
  final String city;
  final String temperature;
  final String weatherType;
  final String weatherDesc;
  final String wind;
  final String pressure;
  final String humidity;

  WeatherLocation({
    @required this.city,
    @required this.temperature,
    @required this.weatherType,
    @required this.weatherDesc,
    @required this.wind,
    @required this.pressure,
    @required this.humidity,
  });
}
