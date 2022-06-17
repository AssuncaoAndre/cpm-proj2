import 'dart:core';

class Utils {
  DateTime getDate(String JSONdate){

    var date = JSONdate.split(' ')[0];
    var year = date.split('-')[0];
    var month = date.split('-')[1];
    var day = date.split('-')[2];

    var time = JSONdate.split(' ')[1];
    var hour = time.split(':')[0];
    var minute = time.split(':')[1];
    var second = time.split(':')[2];

    return DateTime(int.parse(year), int.parse(month), int.parse(day), int.parse(hour), int.parse(second), 0);
  }
}