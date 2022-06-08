import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proj2/favorite_cities.dart';
import 'dart:async';
import 'dart:convert';
import 'constants.dart';
import 'statistics.dart';
import 'favorite_cities.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url =
      'https://api.openweathermap.org/data/2.5/forecast?exclude=hourly,minutely&units=metric&appid=${Constants.apiKey}';
  //String url = 'https://randomuser.me/api/?results=10';
  List data = [];
  bool _isDataLoading = true;
  List city_ids = [];

  Future<List> _getCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < Constants.cities.length; i++) {
      if (prefs.getBool(Constants.cities[i]) == null) {
        prefs.setBool(Constants.cities[i], false);
      }

      if (!prefs.getBool(Constants.cities[i])!) {
        for (int j = 0; j < city_ids.length; j++) {
          if (i == city_ids[j]) {
            setState(() {
              data.removeAt(j);
              city_ids.removeAt(j);
            });
          }
        }
        continue;
      }
      int flag = 0;
      for (int j = 0; j < city_ids.length; j++) {
        if (i == city_ids[j]) {
          flag = 1;
          break;
        }
      }
      if (flag == 1) continue;
      var response = await http.get(
        Uri.encodeFull(url + "&q=" + Constants.cities[i]),
        headers: {"Accept": 'application/json'},
      );
      // print(response.body);
      setState(() {
        var listData = json.decode(response.body);
        data.add(listData['list'][0]);
        city_ids.add(i);
      });
    }
    _isDataLoading = false;

    return data;
  }

  @override
  void initState() {
    super.initState();

    _getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Request'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body:
          ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  title: Text(Constants.cities[city_ids[index]]),
                  subtitle: Text(data[index]['main']['temp'].toString() + "º"),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(Constants.iconsApi +
                        data[index]['weather'][0]['icon'] +
                        Constants.imageEnd),
                  ),
                  onTap: () {
                    // pass single user data to detail page
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                StatisticsPage(Constants.cities[index])));
                  },
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => FavoriteCitiesPage()))
              .then((value) {
            _getCities();
          });
        },
        backgroundColor: Colors.lightBlue[200],
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
