import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';
import 'package:weather_icons/weather_icons.dart';

class StatisticsPage extends StatefulWidget {
  final city;

  StatisticsPage(this.city);

  @override
  _StatisticsState createState() => _StatisticsState(city);
}

class _StatisticsState extends State<StatisticsPage> {

  final city;
  _StatisticsState(this.city);
  
  String url = 'https://api.openweathermap.org/data/2.5/forecast?exclude=hourly,minutely&units=metric&appid=${Constants.apiKey}';
  //String url = 'https://randomuser.me/api/?results=10';
  
  var data;
  bool _isDataLoading = true;

  Future _getUsers(var url) async{

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

  var topics = <String>['Temperature', 'Feels Like', 'Pressure', 'Sea Level', 'Ground Level', 'Humidity', 'Temperature KF'];
  var JSONtopics = <String>['temp', 'feels_like', 'pressure', 'sea_level', 'grnd_level', 'humidity', 'temp_kf'];

  DateTime getDate(String JSONdate){

    var date = JSONdate.split(' ')[0];
    var year = date.split('-')[0];
    var month = date.split('-')[1];
    var day = date.split('-')[2];

    var time = JSONdate.split(' ')[1];
    var hour = time.split(':')[0];
    var minute = time.split(':')[1];
    var second = time.split(':')[2];

    //return DateFormat('MM/dd:kk').format(DateTime(int.parse(year), int.parse(month), int.parse(day), int.parse(hour), int.parse(second)));
    return DateTime(int.parse(year), int.parse(month), int.parse(day), int.parse(hour), int.parse(second), 0);

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
            ? Center(
                child: CircularProgressIndicator()
            )
            : WeatherInfo(data)
    );
  }
}

class WeatherInfo extends StatelessWidget {

  var data;

  WeatherInfo(this.data);

  var JSONtopics = <String>['temp', 'feels_like', 'pressure', 'sea_level', 'grnd_level', 'humidity', 'temp_kf'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: SingleChildScrollView( child: Column(
        children: [
          CurrentConditions(data),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          AdditionalInfo(data[0]['main']['feels_like'], data[0]['main']['pressure'], data[0]['main']['humidity'], data[0]['wind']['speed']),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Next Days Preview', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20), textAlign: TextAlign.left),
          NextDaysWeatherSwipePager(data)
        ],
      ))
    );
  }
}

class AdditionalInfo extends StatelessWidget {

  var feels_like;
  var pressure;
  var humidity;
  var wind;

  AdditionalInfo(this.feels_like, this.pressure, this.humidity, this.wind);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
      children: <Widget>[
        Column(
          children: [
            BoxedIcon(WeatherIcons.thermometer),
            SizedBox(height: 10),
            Text("Feels Like", style: TextStyle(color: Colors.black54, fontSize: 16)),
            SizedBox( height: 10),
            Text('${this.feels_like}º', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
          ],
        ),
        Column(
          children: [
            BoxedIcon(WeatherIcons.wind),
            SizedBox(height: 10),
            Text("Wind", style: TextStyle(color: Colors.black54, fontSize: 16)),
            SizedBox( height: 10),
            Text('${this.wind} km/h', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
          ],
        ),
        Column(
          children: [
            BoxedIcon(WeatherIcons.humidity),
            SizedBox(height: 10),
            Text("Humidity", style: TextStyle(color: Colors.black54, fontSize: 16)),
            SizedBox( height: 10),
            Text('${this.humidity}%', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
          ],
        ),
        Column(
          children: [
            BoxedIcon(WeatherIcons.thermometer_internal),
            SizedBox(height: 10),
            Text("Pressure", style: TextStyle(color: Colors.black54, fontSize: 16)),
            SizedBox( height: 10),
            Text('${this.pressure}%', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
          ],
        )
      ],
    ));
  }
}

class NextDaysWeatherSwipePager extends StatelessWidget {

  var data;

  NextDaysWeatherSwipePager(this.data);

  var JSONtopics = <String>['temp', 'feels_like', 'pressure', 'sea_level', 'grnd_level', 'humidity', 'temp_kf'];

  DateTime getDate(String JSONdate){

    var date = JSONdate.split(' ')[0];
    var year = date.split('-')[0];
    var month = date.split('-')[1];
    var day = date.split('-')[2];

    var time = JSONdate.split(' ')[1];
    var hour = time.split(':')[0];
    var minute = time.split(':')[1];
    var second = time.split(':')[2];

    //return DateFormat('MM/dd:kk').format(DateTime(int.parse(year), int.parse(month), int.parse(day), int.parse(hour), int.parse(second)));
    return DateTime(int.parse(year), int.parse(month), int.parse(day), int.parse(hour), int.parse(second), 0);

  }

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: CarouselSlider(
              options: CarouselOptions(
                height: 300,
                enableInfiniteScroll: false,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                // Temperature
                SfCartesianChart(
                    title: ChartTitle(text: 'Temperature'),
                    // Enables the tooltip for all the series in chart
                    tooltipBehavior: TooltipBehavior(
                        enable: true),
                    // Initialize category axis
                    primaryXAxis: DateTimeCategoryAxis(
                      dateFormat: DateFormat.E(),
                      labelRotation: 90,
                      majorTickLines: const MajorTickLines(
                          size: 6,
                          width: 2,
                          color: Colors.blue
                      ),
                    ),
                    primaryYAxis: NumericAxis(),
                    enableAxisAnimation: true,
                    series: <ChartSeries>[
                      // Initialize line series
                      LineSeries<TimeSeriesTemp, DateTime>(
                        // Enables the tooltip for individual series
                          enableTooltip: true,
                          dataSource: List.generate(
                              data.length, (j) =>
                              TimeSeriesTemp(getDate(
                                  data[j]['dt_txt']),
                                  (data[j]['main'][JSONtopics[0]] +
                                      .0))),
                          xValueMapper: (
                              TimeSeriesTemp data,
                              _) => data.time,
                          yValueMapper: (
                              TimeSeriesTemp data,
                              _) => data.value
                      )
                    ]
                ),
                //Feels Like
                SfCartesianChart(
                    title: ChartTitle(text: 'Feels Like'),
                    // Enables the tooltip for all the series in chart
                    tooltipBehavior: TooltipBehavior(
                        enable: true),
                    // Initialize category axis
                    primaryXAxis: DateTimeCategoryAxis(
                      dateFormat: DateFormat.E(),
                      labelRotation: 90,
                      majorTickLines: const MajorTickLines(
                          size: 6,
                          width: 2,
                          color: Colors.blue
                      ),
                    ),
                    primaryYAxis: NumericAxis(),
                    enableAxisAnimation: true,
                    series: <ChartSeries>[
                      // Initialize line series
                      LineSeries<TimeSeriesTemp, DateTime>(
                        // Enables the tooltip for individual series
                          enableTooltip: true,
                          dataSource: List.generate(
                              data.length, (j) =>
                              TimeSeriesTemp(getDate(
                                  data[j]['dt_txt']),
                                  (data[j]['main'][JSONtopics[1]] +
                                      .0))),
                          xValueMapper: (
                              TimeSeriesTemp data,
                              _) => data.time,
                          yValueMapper: (
                              TimeSeriesTemp data,
                              _) => data.value
                      )
                    ]
                ),
                //Pressure
                SfCartesianChart(
                  title: ChartTitle(text: 'Pressure'),
                  // Enables the tooltip for all the series in chart
                  tooltipBehavior: TooltipBehavior(
                      enable: true),
                  // Initialize category axis
                  primaryXAxis: DateTimeCategoryAxis(
                    dateFormat: DateFormat.E(),
                    labelRotation: 90,
                    majorTickLines: const MajorTickLines(
                        size: 6,
                        width: 2,
                        color: Colors.blue
                    ),
                  ),
                  primaryYAxis: NumericAxis(),
                  enableAxisAnimation: true,
                  series: <ChartSeries>[
                    // Initialize line series
                    LineSeries<TimeSeriesTemp, DateTime>(
                      // Enables the tooltip for individual series
                        enableTooltip: true,
                        dataSource: List.generate(
                            data.length, (j) =>
                            TimeSeriesTemp(getDate(
                                data[j]['dt_txt']),
                                (data[j]['main'][JSONtopics[2]] +
                                    .0))),
                        xValueMapper: (
                            TimeSeriesTemp data,
                            _) => data.time,
                        yValueMapper: (
                            TimeSeriesTemp data,
                            _) => data.value
                    )
                  ]
              ),
                //Sea Level
                SfCartesianChart(
                    title: ChartTitle(text: 'Sea Level'),
                    // Enables the tooltip for all the series in chart
                    tooltipBehavior: TooltipBehavior(
                        enable: true),
                    // Initialize category axis
                    primaryXAxis: DateTimeCategoryAxis(
                      dateFormat: DateFormat.E(),
                      labelRotation: 90,
                      majorTickLines: const MajorTickLines(
                          size: 6,
                          width: 2,
                          color: Colors.blue
                      ),
                    ),
                    primaryYAxis: NumericAxis(),
                    enableAxisAnimation: true,
                    series: <ChartSeries>[
                      // Initialize line series
                      LineSeries<TimeSeriesTemp, DateTime>(
                        // Enables the tooltip for individual series
                          enableTooltip: true,
                          dataSource: List.generate(
                              data.length, (j) =>
                              TimeSeriesTemp(getDate(
                                  data[j]['dt_txt']),
                                  (data[j]['main'][JSONtopics[3]] +
                                      .0))),
                          xValueMapper: (
                              TimeSeriesTemp data,
                              _) => data.time,
                          yValueMapper: (
                              TimeSeriesTemp data,
                              _) => data.value
                      )
                    ]
                ),
                //Ground Level
                SfCartesianChart(
                  title: ChartTitle(text: 'Ground Level'),
                  // Enables the tooltip for all the series in chart
                  tooltipBehavior: TooltipBehavior(
                      enable: true),
                  // Initialize category axis
                  primaryXAxis: DateTimeCategoryAxis(
                    dateFormat: DateFormat.E(),
                    labelRotation: 90,
                    majorTickLines: const MajorTickLines(
                        size: 6,
                        width: 2,
                        color: Colors.blue
                    ),
                  ),
                  primaryYAxis: NumericAxis(),
                  enableAxisAnimation: true,
                  series: <ChartSeries>[
                    // Initialize line series
                    LineSeries<TimeSeriesTemp, DateTime>(
                      // Enables the tooltip for individual series
                        enableTooltip: true,
                        dataSource: List.generate(
                            data.length, (j) =>
                            TimeSeriesTemp(getDate(
                                data[j]['dt_txt']),
                                (data[j]['main'][JSONtopics[4]] +
                                    .0))),
                        xValueMapper: (
                            TimeSeriesTemp data,
                            _) => data.time,
                        yValueMapper: (
                            TimeSeriesTemp data,
                            _) => data.value
                    )
                  ]
              )
              ]
          ),
        ));
  }
}

class CurrentConditions extends StatelessWidget {

  var data;
  var JSONtopics = <String>['temp', 'feels_like', 'pressure', 'sea_level', 'grnd_level', 'humidity', 'temp_kf'];

  CurrentConditions(this.data);


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '${data[0]['main'][JSONtopics[0]]}º',
          style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w100),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Column(
            children: [
              SizedBox(height: 10),
              Text("Max", style: TextStyle(color: Colors.black54, fontSize: 16)),
              SizedBox( height: 10),
              Text('${data[0]['main']['temp_max']}º', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Center(
                child: Container(
                  width: 1,
                  height: 30,
                )),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(Constants.iconsApi +
                data[0]['weather'][0]['icon'] +
                Constants.imageEnd),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Center(
                child: Container(
                  width: 1,
                  height: 30,
                )),
          ),
          Column(
            children: [
              SizedBox(height: 10),
              Text("Min", style: TextStyle(color: Colors.black54, fontSize: 16)),
              SizedBox( height: 10),
              Text('${data[0]['main']['temp_min']}º', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
            ],
          ),
        ]),
      ],
    );
  }
}
class TimeSeriesTemp {
  final DateTime time;
  final double value;

  TimeSeriesTemp(this.time, this.value);
}
