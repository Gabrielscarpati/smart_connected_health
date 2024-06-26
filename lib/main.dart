import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_connected_health/provider/user_provider.dart';

import 'charts/chat_screen.dart';
import 'log_in/log_in_screen.dart';

//syncfusion_flutter_charts

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseAuth.instance.signOut();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LogInSignUpProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Material(
        child: FirebaseAuth.instance.currentUser != null
            ? const ChartScreen()
            : const LogInScreen(),
      ),
    );
  }
}

//syncfusion_flutter_charts: ^24.1.41
//sentiment score on the y
//axis and the days on the x axis
