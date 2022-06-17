import 'package:flutter/material.dart';
import 'package:proj2/services/HttpRequests.dart';
import 'package:proj2/services/sharedPreferences.dart';
import 'package:proj2/views/favorite_cities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import '../models/constants.dart';
import '../commands/statistics.dart';r
import 'favorite_cities.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List data = [];
  List city_ids = [];

  Future<List> getCities() async {
    await MySharedPreferences().getSharedPreferences().then((SharedPreferences prefs) {

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
      HttpRequests().responseBodyCities(i).then((String response) {
          setState(() {
            var listData = json.decode(response);
            data.add(listData['list'][0]);
            city_ids.add(i);
          });
        }
      );
    }

    });

    return data;
  }

  @override
  void initState() {
    super.initState();

    getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              title: Text(Constants.cities[city_ids[index]]),
              subtitle: Text("${data[index]['main']['temp'].round()}º"),
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
                            StatisticsPage(Constants.cities[city_ids[index]])));
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
            getCities();
          });
        },
        backgroundColor: Colors.lightBlue[200],
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
