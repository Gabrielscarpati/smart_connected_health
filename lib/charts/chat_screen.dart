import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final DateTime x;
  final double y;

  ChartData(this.x, this.y);
}

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(DateTime(2013), 40),
      ChartData(DateTime(2014), 30),
      ChartData(DateTime(2015), 20),
      ChartData(DateTime(2016), 10),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Step Line Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 4, top: 12),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                  ),
                  child: Container(
                    color: Colors.white,
                    height: 300,
                    width: double.infinity,
                    child: SfCartesianChart(
                      primaryXAxis: const DateTimeAxis(),
                      series: <CartesianSeries>[
                        StepLineSeries<ChartData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 300,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        'Very Happy',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 37),
                      Text(
                        textAlign: TextAlign.start,
                        'Happy',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 37),
                      Text(
                        textAlign: TextAlign.start,
                        'Neutral',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 37),
                      Text(
                        textAlign: TextAlign.start,
                        'Sad',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
