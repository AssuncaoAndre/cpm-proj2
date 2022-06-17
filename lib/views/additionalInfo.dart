import 'dart:core';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class AdditionalInfo extends StatelessWidget {

  var feels_like;
  var pressure;
  var humidity;
  var wind;

  AdditionalInfo(this.feels_like, this.pressure, this.humidity, this.wind, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            Column(
              children: [
                const BoxedIcon(WeatherIcons.thermometer),
                const SizedBox(height: 10),
                const Text("Feels Like", style: TextStyle(color: Colors.black54, fontSize: 16)),
                const SizedBox( height: 10),
                Text('$feels_likeº', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
              ],
            ),
            Column(
              children: [
                const BoxedIcon(WeatherIcons.wind),
                const SizedBox(height: 10),
                const Text("Wind", style: TextStyle(color: Colors.black54, fontSize: 16)),
                const SizedBox( height: 10),
                Text('$wind km/h', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
              ],
            ),
            Column(
              children: [
                const BoxedIcon(WeatherIcons.humidity),
                const SizedBox(height: 10),
                const Text("Humidity", style: TextStyle(color: Colors.black54, fontSize: 16)),
                const SizedBox( height: 10),
                Text('$humidity%', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
              ],
            ),
            Column(
              children: [
                const BoxedIcon(WeatherIcons.thermometer_internal),
                const SizedBox(height: 10),
                const Text("Pressure", style: TextStyle(color: Colors.black54, fontSize: 16)),
                const SizedBox( height: 10),
                Text('$pressure%', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
              ],
            )
          ],
        ));
  }
}