import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'landing_page.dart';
import '../user/registration.dart';
import 'package:camera/camera.dart';

class Recognize extends StatefulWidget {
  const Recognize({super.key});

  @override
  State<Recognize> createState() => _RecognizeState();
}

class _RecognizeState extends State<Recognize> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
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

  Future<void> chooseImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
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
          // Full-screen camera preview
          _isCameraInitialized
              ? CameraPreview(_cameraController!)
              : Center(child: CircularProgressIndicator()),

          // Overlay for controls
          Positioned(
            top: 4,
            left: 20, // Move the back button to the top left
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
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
            right: 20, // Keep the registration button on the top right
            child: SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: continueToRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF250000),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Continue to Register"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
