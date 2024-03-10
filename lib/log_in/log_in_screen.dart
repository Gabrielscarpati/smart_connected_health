import 'package:flutter/material.dart';
import 'package:smart_connected_health/log_in/views/log_in_body.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LogInBody(),
    );
  }
}
