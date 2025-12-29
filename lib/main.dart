import 'package:flutter/material.dart';
import 'package:ofss_bihar_info/utils/Utils.dart';
import 'package:ofss_bihar_info/view_controller/DashBoardScreen.dart';
import 'package:ofss_bihar_info/view_controller/PreLoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load login state from SharedPreferences
  bool isLoggedIn = await Utils.getBoolFromPrefs('isLogin') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isLoggedIn
          ? const DashboardScreen(userData: {})
          : const PreLoginScreen(),
    );
  }
}

