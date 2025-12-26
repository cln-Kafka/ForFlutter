import 'package:flutter/material.dart';
import 'package:ocr_scanner/main_app_theme.dart';
import 'package:ocr_scanner/methods_menu_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElMaghrabi Scanner',
      debugShowCheckedModeBanner: false,
      theme: MainAppTheme.lightTheme,
      home: MethodsMenuView(),
    );
  }
}
