import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class MySharedPreferences {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }
}