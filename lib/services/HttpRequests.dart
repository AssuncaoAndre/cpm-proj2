import 'package:http/http.dart' as http;
import '../models/constants.dart';
import 'dart:async';

class HttpRequests {

  String url = 'https://api.openweathermap.org/data/2.5/forecast?exclude=hourly,minutely&units=metric&appid=${Constants.apiKey}';

  Future<String> responseBody(String cityName) async {
    var httpResponse = await http.get(
      Uri.encodeFull('$url&q=$cityName'),
      headers: {"Accept": 'application/json'},
    );
    return httpResponse.body;
  }

  Future<String> responseBodyCities(int cityIndex) async {
    var httpResponse = await http.get(
      Uri.encodeFull("$url&q=${Constants.cities[cityIndex]}"),
      headers: {"Accept": 'application/json'},
    );
    return httpResponse.body;
  }
}