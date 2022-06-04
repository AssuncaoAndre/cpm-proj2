import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './detail.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCitiesPage extends StatefulWidget {
  @override
  _FavoriteCitiesPage createState() => _FavoriteCitiesPage();
}

class _FavoriteCitiesPage extends State<FavoriteCitiesPage> {
  String url =
      'https://api.openweathermap.org/data/2.5/forecast?lat=33.44&lon=-94.04&exclude=hourly,minutely&units=metric&appid=${Constants.apiKey}';
  //String url = 'https://randomuser.me/api/?results=10';
  List data = [];

  bool _isDataLoading = true;
  Future<List> _getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < Constants.cities.length; i++) {
      setState(() {
        data.add(prefs.getBool(Constants.cities[i]));
      });
    }
    _isDataLoading = false;

    return data;
  }

  @override
  void initState() {
    super.initState();

    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final addButtonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: Colors.blueAccent,
      shape: RoundedRectangleBorder(
          //to set border radius to button
          borderRadius: BorderRadius.circular(30)),
    );

    final removeButtonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: Colors.redAccent,
      shape: RoundedRectangleBorder(
          //to set border radius to button
          borderRadius: BorderRadius.circular(30)),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('Http Request'),
        ),
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, index) {
              return data[index] == false
                  ? ListTile(
                      title: Text(Constants.cities[index]),
                      leading: ElevatedButton(
                        style: addButtonStyle,
                        onPressed: () async {
                          setState(() {
                            data[index] = true;
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool(Constants.cities[index], true);
                        },
                        child: const Text('Add'),
                      ),
                    )
                  : ListTile(
                      title: Text(Constants.cities[index]),
                      leading: ElevatedButton(
                        style: removeButtonStyle,
                        onPressed: () async {
                          setState(() {
                            data[index] = false;
                          });

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool(Constants.cities[index], false);
                        },
                        child: const Text('Remove'),
                      ),
                    );
            }));
  }
}
