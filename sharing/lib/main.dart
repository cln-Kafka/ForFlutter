import 'package:flutter/material.dart';
import 'package:sharing/home_view.dart';

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
      home: HomeView(),
    );
  }
}
