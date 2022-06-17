import 'dart:core';
import 'package:flutter/material.dart';
import 'additionalInfo.dart';
import 'currentConditions.dart';
import 'nextDaysWeatherswipePager.dart';

class WeatherInfo extends StatelessWidget {

  var data;

  WeatherInfo(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView( child: Column(
          children: [
            CurrentConditions(data),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            AdditionalInfo(data[0]['main']['feels_like'], data[0]['main']['pressure'], data[0]['main']['humidity'], data[0]['wind']['speed']),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Next Days Preview', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20), textAlign: TextAlign.left),
            NextDaysWeatherSwipePager(data)
          ],
        ))
    );
  }
}