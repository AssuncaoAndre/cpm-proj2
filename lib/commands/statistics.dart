import 'dart:core';
import 'package:flutter/material.dart';
import 'package:proj2/services/HttpRequests.dart';
import 'package:proj2/views/weatherInfo.dart';
import 'dart:async';
import 'dart:convert';

class StatisticsPage extends StatefulWidget {
  final city;

  StatisticsPage(this.city);

  @override
  _StatisticsState createState() => _StatisticsState(city);
}

class _StatisticsState extends State<StatisticsPage> {

  final city;
  _StatisticsState(this.city);
  
  var data;
  bool _isDataLoading = true;

  Future _getUsers(String cityName) async{

    HttpRequests().responseBody(cityName).then((String response) {
      setState(() {
        var listData = json.decode(response);
        data = listData['list'];

        _isDataLoading = false;
      });
    });

    return data;
  }

  @override
  void initState() {

    super.initState();

    _getUsers(city);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
          title: Text(city),
          backgroundColor: Colors.lightBlue[100],
        ),
        body: _isDataLoading
            ? const Center(
                child: CircularProgressIndicator()
            )
            : WeatherInfo(data)
    );
  }
}