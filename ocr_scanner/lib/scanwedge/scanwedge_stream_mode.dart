import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:scanwedge/scanwedge.dart';

class ScanWedgeStreamMode extends StatefulWidget {
  const ScanWedgeStreamMode({super.key});

  @override
  State<ScanWedgeStreamMode> createState() => _ScanWedgeStreamModeState();
}

class _ScanWedgeStreamModeState extends State<ScanWedgeStreamMode> {
  Scanwedge? _scanwedge;
  String? confirmedResult;

  @override
  void initState() {
    super.initState();
    _initScanner();
  }

  Future<void> _initScanner() async {
    try {
      final scanwedge = await Scanwedge.initialize();
      _scanwedge = scanwedge;

      // Honeywell stream-only profile
      await scanwedge.createScanProfile(
        HoneywellProfileModel(
          profileName: 'StreamModeDemo',
          // enableKeyStroke: false, // IMPORTANT
          enabledBarcodes: [
            BarcodeConfig(barcodeType: BarcodeTypes.code128),
            BarcodeConfig(barcodeType: BarcodeTypes.ean13),
          ],
        ),
      );

      // Listen to scan results
      scanwedge.stream.listen((ScanResult result) {
        _onScanReceived(result.barcode);
      });

      setState(() {});
    } catch (e) {
      log('Scanner init error: $e');
    }
  }

  void _onScanReceived(String barcode) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Confirm scan'),
        content: Text(barcode),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              confirmedResult = barcode;
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<void> _triggerSoftScan() async {
    try {
      await _scanwedge?.toggleScanning();
    } catch (e) {
      log('Trigger error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ScanWedge Stream Scan Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _scanwedge == null ? null : _triggerSoftScan,
              child: const Text('Scan'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Confirmed scan result:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                confirmedResult ?? '—',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
