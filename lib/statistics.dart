import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './detail.dart';
import 'constants.dart';



class StatisticsPage extends StatefulWidget {
  final city;

  StatisticsPage(this.city);

  @override
  _StatisticsState createState() => _StatisticsState(city);
}

class _StatisticsState extends State<StatisticsPage> {

  final city;
  _StatisticsState(this.city);
  
  String url = 'https://api.openweathermap.org/data/2.5/forecast?lat=33.44&lon=-94.04&exclude=hourly,minutely&units=metric&appid=${Constants.apiKey}';
  //String url = 'https://randomuser.me/api/?results=10';
  
  late List data;
  bool _isDataLoading = true;

  Future<List> _getUsers(var url) async{

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": 'application/json'},
    );

    setState(() {

      var listData = json.decode(response.body);
      data = listData['list'];

      _isDataLoading = false;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();

    _getUsers('$url&q=${this.city}');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Http Request'),
        ),
        body: _isDataLoading
            ? Center(
            child: CircularProgressIndicator()
        )
            : ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, index){
              return ListTile(
                title: Text(data[index]['dt_txt']),
                subtitle: Text(data[index]['main']['temp'].toString()+"ºC"),
                leading:  CircleAvatar(
                  backgroundImage: NetworkImage(Constants.iconsApi+data[index]['weather'][0]['icon']+Constants.imageEnd),
                ) ,
              );
            }
        )
    );
  }
}