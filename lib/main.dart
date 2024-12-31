import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/core/constant/colors.dart';
import 'package:to_do_list/screens/tasks_view.dart';
import 'screens/home.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: AppColors.primary,
          iconTheme: IconThemeData(color: AppColors.icons),
          fontFamily: "Tajwal"),
      home: Home(),
      routes: {
        "home": (context) => Home(),
        "tasksView": (context) => TasksView(),
      },
    );
  }
}
