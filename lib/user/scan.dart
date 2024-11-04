import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../user/registration.dart';
import '../user/widgets/buttons.dart';
import 'landing_page.dart';

class Recognize extends StatefulWidget {
  const Recognize({super.key});

  @override
  State<Recognize> createState() => _RecognizeState();
}

class _RecognizeState extends State<Recognize> {
  File? _image;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  List<Face> _detectedFaces = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras.first, ResolutionPreset.max);

    await _cameraController?.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final XFile image = await _cameraController!.takePicture();
        setState(() {
          _image = File(image.path);
        });

        final options = FaceDetectorOptions(
          performanceMode: FaceDetectorMode.accurate,
          enableContours: true,
          enableClassification: true,
        );
        final faceDetector = FaceDetector(options: options);

        final inputImage = InputImage.fromFilePath(_image!.path);
        final List<Face> faces = await faceDetector.processImage(inputImage);

        setState(() {
          _detectedFaces = faces;
        });

        if (_detectedFaces.isNotEmpty) {
          print('Faces detected: ${_detectedFaces.length}');
        } else {
          print('No faces detected.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('No face detected. Please try again.')),
          );
        }

        await faceDetector.close();
      } catch (e) {
        print('Error capturing image: $e');
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          _isCameraInitialized
              ? CameraPreview(_cameraController!)
              : const Center(child: CircularProgressIndicator()),
          if (_isCameraInitialized && _detectedFaces.isNotEmpty)
            CustomPaint(
              painter: FacePainter(_detectedFaces, MediaQuery.of(context).size),
            ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: ElevatedButton(
              onPressed: _captureImage,
              child:
                  const Icon(Icons.camera_alt, size: 30, color: Colors.white),
            ),
          ),
          Positioned(
            top: 4,
            left: 20,
            child: CustomBackButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GetStartedPage()),
                  (route) => false,
                );
              },
            ),
          ),
          Positioned(
            top: 4,
            right: 20,
            child: ContinueButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  final List<Face> faces;
  final Size screenSize;

  FacePainter(this.faces, this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    for (var face in faces) {
      final boundingBox = face.boundingBox;
      final rect = Rect.fromLTRB(
        boundingBox.left * screenSize.width / size.width,
        boundingBox.top * screenSize.height / size.height,
        boundingBox.right * screenSize.width / size.width,
        boundingBox.bottom * screenSize.height / size.height,
      );

      // Draw the rectangle around the face
      canvas.drawRect(rect, paint);

      // Draw the label text above the rectangle
      final textSpan = TextSpan(
        text: 'Face Detected',
        style: TextStyle(color: Colors.red, fontSize: 16),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(rect.left, rect.top - 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
