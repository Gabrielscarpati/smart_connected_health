import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../answer_question.dart';
import '../provider/user_provider.dart';

class ChartData {
  final int days;
  final double y;

  ChartData(this.days, this.y);
}

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<ChartData> chartData = [];
  int state = 0;

  @override
  Widget build(BuildContext context) {
    LogInSignUpProvider logInSignUpProvider =
        context.watch<LogInSignUpProvider>();

    String month = getAbbreviatedMonthName();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Welcome: ${logInSignUpProvider.userFirstName}"),
          leading: const SizedBox()),
      body: FutureBuilder<void>(
        future: fetchEmotionsByUserId(FirebaseAuth.instance.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              );
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 312,
                      width: 360,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 4, top: 12),
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
                                      series: <CartesianSeries>[
                                        StepLineSeries<ChartData, int>(
                                          dataSource: chartData,
                                          xValueMapper: (ChartData data, _) =>
                                              data.days,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  height: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        textAlign: TextAlign.start,
                                        'Very Happy',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(height: 46),
                                      const Text(
                                        textAlign: TextAlign.start,
                                        'Happy',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(height: 46),
                                      const Text(
                                        textAlign: TextAlign.start,
                                        'Neutral',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(height: 46),
                                      const Text(
                                        textAlign: TextAlign.start,
                                        'Sad',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(height: 46),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          month + ':',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10.5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnswerQuestion()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> fetchEmotionsByUserId(String userId) async {
    chartData = [];

    LogInSignUpProvider logInSignUpProvider =
        context.watch<LogInSignUpProvider>();
    logInSignUpProvider.userFirstName =
        await logInSignUpProvider.getFirstNameByUserId(userId);

    if (state == 0) {
      setState(() {});
    }
    state = 1;
    chartData = [];

    CollectionReference emotions =
        FirebaseFirestore.instance.collection('emotions');
    QuerySnapshot querySnapshot = await emotions.get();

    List<Map<String, dynamic>> filteredEmotions = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .where((data) => data['userId'] == userId)
        .toList();
    filteredEmotions.sort((a, b) => b['date'].compareTo(a['date']));
    chartData = [];

    for (var emotion in filteredEmotions) {
      int dateTime;
      if (emotion['date'] is Timestamp) {
        dateTime = (emotion['date'] as Timestamp).toDate().day;
      } else {
        continue;
      }

      chartData.add(ChartData(dateTime, emotion['score']));
    }

    int i = 0;
    for (var data in chartData) {
      i++;
      if (i == 10) {
        break;
      }
    }
  }
}

String getAbbreviatedMonthName() {
  int month = DateTime.now().month;
  DateTime date = DateTime(DateTime.now().year, month);
  return DateFormat.MMM().format(date);
}
