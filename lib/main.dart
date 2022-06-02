import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './detail.dart';
import 'constants.dart';
import 'statistics.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter HTTP request',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = 'https://api.openweathermap.org/data/2.5/forecast?exclude=hourly,minutely&units=metric&appid=${Constants.apiKey}';
  //String url = 'https://randomuser.me/api/?results=10';
  List data= [];
  bool _isDataLoading = true;

  Future<List> _getUsers() async{
    for (int i=0; i<Constants.cities.length;i++)
    {
      var response = await http.get(
        Uri.encodeFull(url+"&q="+Constants.cities[i]),
        headers: {"Accept": 'application/json'},
      );

      setState(() {
        var listData = json.decode(response.body);
        data.add(listData['list'][0]);
        _isDataLoading = false;
      });
    }
    
    return data;
  }

  @override
  void initState() {
    super.initState();

    _getUsers();

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
                title: Text(Constants.cities[index]),
                subtitle: Text(data[index]['main']['temp'].toString()+"ºC"),
                leading:  CircleAvatar(
                  backgroundImage: NetworkImage(Constants.iconsApi+data[index]['weather'][0]['icon']+Constants.imageEnd),
                ) ,
                onTap: (){
                  
                  // pass single user data to detail page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context)=> StatisticsPage(Constants.cities[index])));
                },
              );
            }
        )
    );
  }
}