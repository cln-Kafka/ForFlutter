import 'package:flutter/material.dart';
import 'package:sharing/constants.dart';
import 'package:sharing/views/home_view.dart';

void main() {
  runApp(const SharingApp());
}

class SharingApp extends StatelessWidget {
  const SharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sharing Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kBackgroundColor,
            foregroundColor: kForegroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
      home: HomeView(),
    );
  }
}
