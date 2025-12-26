import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class BarcodeCameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const BarcodeCameraScreen({super.key, required this.camera});

  @override
  State<BarcodeCameraScreen> createState() => _BarcodeCameraScreenState();
}

class _BarcodeCameraScreenState extends State<BarcodeCameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late BarcodeScanner _barcodeScanner;
  bool _isProcessing = false;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      _startImageStream();
    });
    _barcodeScanner = BarcodeScanner();
  }

  @override
  void dispose() {
    _controller.dispose();
    _barcodeScanner.close();
    super.dispose();
  }

  void _startImageStream() {
    _controller.startImageStream((CameraImage image) {
      if (!_isProcessing && _isScanning) {
        _isProcessing = true;
        _processImage(image);
      }
    });
  }

  Future<void> _processImage(CameraImage image) async {
    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize = Size(
        image.width.toDouble(),
        image.height.toDouble(),
      );

      final InputImageRotation imageRotation = InputImageRotation.rotation0deg;

      final InputImageFormat inputImageFormat =
          InputImageFormat.nv21; // for Android
      // For iOS, you might need InputImageFormat.bgra8888

      final inputImageData = InputImageMetadata(
        size: imageSize,
        rotation: imageRotation,
        format: inputImageFormat,
        bytesPerRow: image.planes.first.bytesPerRow,
      );

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: inputImageData,
      );

      final List<Barcode> barcodes =
          await _barcodeScanner.processImage(inputImage);

      if (barcodes.isNotEmpty && _isScanning) {
        final barcode = barcodes.first;
        final barcodeValue = barcode.displayValue ?? barcode.rawValue ?? '';
        final barcodeTypeString = _getBarcodeType(barcode.type);

        if (barcodeValue.isNotEmpty) {
          _isScanning = false;
          await _controller.stopImageStream();

          if (!mounted) return;

          Navigator.pop(context, {
            'value': barcodeValue,
            'type': barcodeTypeString,
          });
        }
      }
    } catch (e) {
      // Handle errors silently during streaming
    } finally {
      _isProcessing = false;
    }
  }

  String _getBarcodeType(BarcodeType type) {
    switch (type) {
      case BarcodeType.contactInfo:
        return 'Contact Info';
      case BarcodeType.email:
        return 'Email';
      case BarcodeType.isbn:
        return 'ISBN';
      case BarcodeType.phone:
        return 'Phone';
      case BarcodeType.product:
        return 'Product';
      case BarcodeType.sms:
        return 'SMS';
      case BarcodeType.text:
        return 'Text';
      case BarcodeType.url:
        return 'URL';
      case BarcodeType.wifi:
        return 'WiFi';
      case BarcodeType.geoCoordinates:
        return 'Geo Coordinates';
      case BarcodeType.calendarEvent:
        return 'Calendar Event';
      case BarcodeType.driverLicense:
        return 'Driver License';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Barcode'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                SizedBox.expand(child: CameraPreview(_controller)),
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Point camera at barcode',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}