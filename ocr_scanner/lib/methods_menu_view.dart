import 'package:flutter/material.dart';
import 'package:ocr_scanner/mlkit_barcode/mlkit_barcode_home_view.dart';
import 'package:ocr_scanner/mlkit_digits/mlkit_digits_home_view.dart';

class MethodsMenuView extends StatelessWidget {
  const MethodsMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Methods Menu',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MlkitDigitsHomeView(),
                      ),
                    );
                  },
                  child: Text('MLKit Digits'),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MlkitBarcodeHomeView(),
                      ),
                    );
                  },
                  child: Text('MLKit BarCode'),
                ),
                FilledButton(
                  onPressed: () {},
                  child: Text('ScanWidge Package'),
                ),
                FilledButton(
                  onPressed: () {},
                  child: Text('HoneyWell Package'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
