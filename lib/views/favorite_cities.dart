import 'package:flutter/material.dart';
import 'package:proj2/services/sharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../models/constants.dart';

class FavoriteCitiesPage extends StatefulWidget {
  @override
  _FavoriteCitiesPage createState() => _FavoriteCitiesPage();
}

class _FavoriteCitiesPage extends State<FavoriteCitiesPage> {
  List data = [];

  Future<List> _getUsers() async {

    await MySharedPreferences().getSharedPreferences().then((SharedPreferences prefs) {
      for (int i = 0; i < Constants.cities.length; i++) {
        setState(() {
          data.add(prefs.getBool(Constants.cities[i]));
        });
      }
    });

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
      primary: Colors.green,
      shape: RoundedRectangleBorder(
          //to set border radius to button
          borderRadius: BorderRadius.circular(30)),
    );

    final removeButtonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: Colors.red,
      shape: RoundedRectangleBorder(
          //to set border radius to button
          borderRadius: BorderRadius.circular(30)),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('District Capitals of Portugal'),
          backgroundColor: Colors.lightBlue[100],
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
                          await MySharedPreferences().getSharedPreferences().then((SharedPreferences prefs) {
                            prefs.setBool(Constants.cities[index], true);
                          });
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

                          await MySharedPreferences().getSharedPreferences().then((SharedPreferences prefs) {
                            prefs.setBool(Constants.cities[index], false);
                          });
                        },
                        child: const Text('Remove'),
                      ),
                    );
            }));
  }
}
