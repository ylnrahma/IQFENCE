import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FacePage extends StatefulWidget {
  @override
  _FacePageState createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {
  late CameraController _cameraController;
  late FaceDetector _faceDetector;
  bool _isCameraInitialized = false;
  bool _faceDetected = false;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeFaceDetector();
  }

  void _initializeFaceDetector() {
    final options = FaceDetectorOptions(
      enableContours: false,
      enableClassification: true,
    );
    _faceDetector = FaceDetector(options: options);
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    await _cameraController.initialize();

    _cameraController.startImageStream((CameraImage image) async {
      if (_faceDetected) return;
      final WriteBuffer allBytes = WriteBuffer();
      for (var plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final InputImageData imageData = InputImageData(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        imageRotation: InputImageRotation.rotation0deg,
        inputImageFormat: InputImageFormatMethods.fromRawValue(image.format.raw) ?? InputImageFormat.nv21,
        planeData: image.planes.map(
          (Plane plane) {
            return InputImagePlaneMetadata(
              bytesPerRow: plane.bytesPerRow,
              height: plane.height,
              width: plane.width,
            );
          },
        ).toList(),
      );

      final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: imageData);

      final faces = await _faceDetector.processImage(inputImage);
      if (faces.isNotEmpty) {
        _faceDetected = true;
        _saveAttendance();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Wajah terdeteksi! Absensi berhasil.")),
          );
          Navigator.pop(context);
        }
      }
    });

    setState(() => _isCameraInitialized = true);
  }

  Future<void> _saveAttendance() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final timestamp = DateTime.now().toIso8601String();
      await _database.child("absensi/${user.uid}").push().set({
        'email': user.email,
        'timestamp': timestamp,
        'status': 'Hadir',
      });
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Wajah')),
      body: _isCameraInitialized
          ? CameraPreview(_cameraController)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
