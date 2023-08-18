import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:introductory_programming_frontend_teacher/pages/homepage.dart';
import 'package:introductory_programming_frontend_teacher/translations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: const Locale("en", "US"),
      home: const Scaffold(
        backgroundColor: Color.fromRGBO(254, 251, 234, 1),
        body: Center(
          child: HomePage(),
        ),
      ),
    );
  }
}
