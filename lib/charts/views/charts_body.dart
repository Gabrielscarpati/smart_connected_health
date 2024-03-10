import 'package:flutter/cupertino.dart';
import 'package:smart_connected_health/design_system/ds_text.dart';

import 'chart_happy.dart';
import 'chart_sad.dart';

class ChartBody extends StatefulWidget {
  const ChartBody({Key? key}) : super(key: key);

  @override
  State<ChartBody> createState() => _ChartBodyState();
}

class _ChartBodyState extends State<ChartBody> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 54.0,
          ),
          child: DS20LightPurpleTextBold(text: 'Emotion Charts'),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 54.0,
          ),
          child: DS16LightPurpleTextBold(text: 'Happy'),
        ),
        ChartHappiness(),
        Padding(
          padding: EdgeInsets.only(
            left: 54.0,
          ),
          child: DS16LightPurpleTextBold(text: 'Sad'),
        ),
        ChartSad(),
      ],
    );
  }
}
