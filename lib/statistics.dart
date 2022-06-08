import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';

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

    /*
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
     */

    return Scaffold(
        appBar: AppBar(
          title: Text(city),
        ),
        body: _isDataLoading
            ? Center(
            child: CircularProgressIndicator()
        )
            : ListView(
            children: [
                // Temperature
                Text(
                  topics[0],
                  style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                  ),
                ),
                CarouselSlider(
                  options:
                  CarouselOptions(
                    height: 300,
                    enableInfiniteScroll: false,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    Container(
                      height: 300,
                      width: 400,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 100,
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      '${data[0]['main'][JSONtopics[0]]} ºC',
                                      style: const TextStyle(
                                          fontSize: 80,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue
                                      ),
                                    ),
                                    Text(
                                      data[0]['dt_txt'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 400,
                      width: 500,
                      child: Stack(
                        children: [
                          // Image(
                          //   image: AssetImage(currentTemp.image),
                          //   fit: BoxFit.fill,
                          // ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Center(
                                child: Column(
                                  children: [
                                    SfCartesianChart(
                                        title: ChartTitle(text: 'Next Days'),
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
                                  ],
                                )
                            ),
                          )
                        ],
                      ),
                    )
                  ]
              ),

                //Feel Like
                Text(
                topics[1],
                style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                ),
              ),
                CarouselSlider(
                  options:
                  CarouselOptions(
                    height: 300,
                    enableInfiniteScroll: false,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    Container(
                      height: 300,
                      width: 400,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 100,
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      '${data[0]['main'][JSONtopics[1]]} ºC',
                                      style: const TextStyle(
                                          fontSize: 80,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue
                                      ),
                                    ),
                                    Text(
                                      data[0]['dt_txt'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 400,
                      width: 500,
                      child: Stack(
                        children: [
                          // Image(
                          //   image: AssetImage(currentTemp.image),
                          //   fit: BoxFit.fill,
                          // ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Center(
                                child: Column(
                                  children: [
                                    SfCartesianChart(
                                        title: ChartTitle(text: 'Next Days'),
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
                                  ],
                                )
                            ),
                          )
                        ],
                      ),
                    )
                  ]
              ),

                //Pressure
                Text(
                  topics[2],
                  style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                  ),
                ),
                CarouselSlider(
                    options:
                    CarouselOptions(
                      height: 300,
                      enableInfiniteScroll: false,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [
                      Container(
                        height: 300,
                        width: 400,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 100,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        '${data[0]['main'][JSONtopics[2]]} Pa',
                                        style: const TextStyle(
                                            fontSize: 80,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                      Text(
                                        data[0]['dt_txt'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        width: 500,
                        child: Stack(
                          children: [
                            // Image(
                            //   image: AssetImage(currentTemp.image),
                            //   fit: BoxFit.fill,
                            // ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                  child: Column(
                                    children: [
                                      SfCartesianChart(
                                          title: ChartTitle(text: 'Next Days'),
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
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                ),

                //Sea Level
                Text(
                  topics[3],
                  style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                  ),
                ),
                CarouselSlider(
                    options:
                    CarouselOptions(
                      height: 300,
                      enableInfiniteScroll: false,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [
                      Container(
                        height: 300,
                        width: 400,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 100,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        data[0]['main'][JSONtopics[3]].toString(),
                                        style: const TextStyle(
                                            fontSize: 80,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                      Text(
                                        data[0]['dt_txt'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        width: 500,
                        child: Stack(
                          children: [
                            // Image(
                            //   image: AssetImage(currentTemp.image),
                            //   fit: BoxFit.fill,
                            // ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                  child: Column(
                                    children: [
                                      SfCartesianChart(
                                          title: ChartTitle(text: 'Next Days'),
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
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                ),

                //Ground Level
                Text(
                  topics[4],
                  style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                  ),
                ),
                CarouselSlider(
                    options:
                    CarouselOptions(
                      height: 300,
                      enableInfiniteScroll: false,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [
                      Container(
                        height: 300,
                        width: 400,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 100,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        data[0]['main'][JSONtopics[4]].toString(),
                                        style: const TextStyle(
                                            fontSize: 80,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                      Text(
                                        data[0]['dt_txt'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        width: 500,
                        child: Stack(
                          children: [
                            // Image(
                            //   image: AssetImage(currentTemp.image),
                            //   fit: BoxFit.fill,
                            // ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                  child: Column(
                                    children: [
                                      SfCartesianChart(
                                          title: ChartTitle(text: 'Next Days'),
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
                                      ),
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                ),

                //Humidity
                Text(
                  topics[5],
                  style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                  ),
                ),
                CarouselSlider(
                    options:
                    CarouselOptions(
                      height: 300,
                      enableInfiniteScroll: false,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [
                      Container(
                        height: 300,
                        width: 400,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 100,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        '${data[0]['main'][JSONtopics[5]]} g.m^-3',
                                        style: const TextStyle(
                                            fontSize: 80,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                      Text(
                                        data[0]['dt_txt'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        width: 500,
                        child: Stack(
                          children: [
                            // Image(
                            //   image: AssetImage(currentTemp.image),
                            //   fit: BoxFit.fill,
                            // ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                  child: Column(
                                    children: [
                                      SfCartesianChart(
                                          title: ChartTitle(text: 'Next Days'),
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
                                                        (data[j]['main'][JSONtopics[5]] +
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
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                ),

                //Temperature KF
                Text(
                  topics[6],
                  style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                  ),
                ),
                CarouselSlider(
                    options:
                    CarouselOptions(
                      height: 300,
                      enableInfiniteScroll: false,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [
                      Container(
                        height: 300,
                        width: 400,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 100,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        '${data[0]['main'][JSONtopics[6]]} ºC',
                                        style: const TextStyle(
                                            fontSize: 80,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue
                                        ),
                                      ),
                                      Text(
                                        data[0]['dt_txt'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        width: 500,
                        child: Stack(
                          children: [
                            // Image(
                            //   image: AssetImage(currentTemp.image),
                            //   fit: BoxFit.fill,
                            // ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Center(
                                  child: Column(
                                    children: [
                                      SfCartesianChart(
                                          title: ChartTitle(text: 'Next Days'),
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
                                                        (data[j]['main'][JSONtopics[6]] +
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
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                ),

              ]
            ),
    );
  }
}

class TimeSeriesTemp {
  final DateTime time;
  final double value;

  TimeSeriesTemp(this.time, this.value);
}


//Container(child: Text("hello!", style: TextStyle(fontSize: 25)));