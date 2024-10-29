import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
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

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras.first, ResolutionPreset.high);
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
      } catch (e) {
        print('Error capturing image: $e');
      }
    }
  }

  void continueToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color for better visibility
      body: Stack(
        children: <Widget>[
          _isCameraInitialized
              ? CameraPreview(_cameraController!)
              : const Center(child: CircularProgressIndicator()),
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
              onPressed: continueToRegister,
            ),
          ),
        ],
      ),
    );
  }
}
