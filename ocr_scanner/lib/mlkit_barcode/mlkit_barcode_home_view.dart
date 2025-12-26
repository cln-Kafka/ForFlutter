import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ocr_scanner/mlkit_barcode/barcode_camera_screen.dart';

class MlkitBarcodeHomeView extends StatefulWidget {
  const MlkitBarcodeHomeView({super.key});

  @override
  State<MlkitBarcodeHomeView> createState() => _MlkitBarcodeHomeViewState();
}

class _MlkitBarcodeHomeViewState extends State<MlkitBarcodeHomeView> {
  String scannedBarcode = 'No barcode scanned yet';
  String barcodeType = '';

  CameraDescription? firstCamera;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      setState(() {
        firstCamera = cameras.first;
      });
    }
  }

  void _navigateToCamera() async {
    if (firstCamera == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera not initialized yet')),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeCameraScreen(camera: firstCamera!),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        scannedBarcode = result['value'] ?? 'No barcode scanned yet';
        barcodeType = result['type'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.qr_code_scanner, size: 80, color: Colors.blue),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    if (barcodeType.isNotEmpty) ...[
                      Text(
                        'Type: $barcodeType',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    const Text(
                      'Scanned Barcode:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      scannedBarcode,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _navigateToCamera,
                icon: const Icon(Icons.camera_alt, size: 28),
                label: const Text('Scan', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}