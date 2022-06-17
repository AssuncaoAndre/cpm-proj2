import 'dart:core';
import 'package:flutter/material.dart';
import 'package:proj2/models/constants.dart';
import 'package:proj2/models/timeSeriesTemp.dart';
import 'package:proj2/models/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import '../models/constants.dart';

class NextDaysWeatherSwipePager extends StatelessWidget {

  var data;

  NextDaysWeatherSwipePager(this.data, {Key? key}) : super(key: key);

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
                                TimeSeriesTemp(Utils().getDate(
                                    data[j]['dt_txt']),
                                    (data[j]['main'][Constants.JSONtopics[0]] +
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
                                TimeSeriesTemp(Utils().getDate(
                                    data[j]['dt_txt']),
                                    (data[j]['main'][Constants.JSONtopics[1]] +
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
                                TimeSeriesTemp(Utils().getDate(
                                    data[j]['dt_txt']),
                                    (data[j]['main'][Constants.JSONtopics[2]] +
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
                                TimeSeriesTemp(Utils().getDate(
                                    data[j]['dt_txt']),
                                    (data[j]['main'][Constants.JSONtopics[3]] +
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
                                TimeSeriesTemp(Utils().getDate(
                                    data[j]['dt_txt']),
                                    (data[j]['main'][Constants.JSONtopics[4]] +
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