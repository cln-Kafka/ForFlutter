import 'package:flutter/material.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';

// TODO: Can't be tested so code might not be working properly

class HoneywellScannerScreen extends StatefulWidget {
  const HoneywellScannerScreen({super.key});

  @override
  HoneywellScannerScreenState createState() => HoneywellScannerScreenState();
}

class HoneywellScannerScreenState extends State<HoneywellScannerScreen> {
  final HoneywellScanner _scanner = HoneywellScanner();

  String? _scanResult;
  bool _isSupported = false;
  bool _scannerStarted = false;

  @override
  void initState() {
    super.initState();
    _checkSupport();
  }

  /// Check if the current device is supported
  Future<void> _checkSupport() async {
    bool supported = await _scanner.isSupported();
    setState(() => _isSupported = supported);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Device Support"),
        content: Text(
          supported
              ? "This device is supported for Honeywell scanning!"
              : "This device is NOT supported.",
        ),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  /// Set callback listeners
  void _setScannerCallbacks() {
    _scanner.setScannerDecodeCallback((scannedData) {
      setState(() {
        _scanResult = scannedData?.code ?? "No data";
      });
    });

    _scanner.setScannerErrorCallback((error) {
      setState(() {
        _scanResult = "SCAN ERROR: $error";
      });
    });
  }

  /// Start the scanner listener
  Future<void> _startScanner() async {
    _setScannerCallbacks();
    await _scanner.startScanner();
    setState(() => _scannerStarted = true);
  }

  /// Trigger a scan (software trigger)
  Future<void> _triggerScan() async {
    if (!_scannerStarted) await _startScanner();
    await _scanner.startScanning();
  }

  @override
  void dispose() {
    _scanner.disposeScanner();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Honeywell Scanner Demo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Device Supported: ${_isSupported ? "Yes" : "No"}",
              style: TextStyle(
                fontSize: 18,
                color: _isSupported ? Colors.green : Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: _triggerScan, child: Text("Scan")),

            const SizedBox(height: 30),

            Text(
              _scanResult != null
                  ? "Last Scan: $_scanResult"
                  : "Awaiting a scan...",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
