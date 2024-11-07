import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'registration.dart';
import 'widgets/buttons.dart';
import '/admin-panel/login/login_page.dart';

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

        // Show a SnackBar or perform some other action
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image captured successfully!')),
        );
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
                  MaterialPageRoute(builder: (context) => const Admin()),
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
