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
  File? _image; // Variable to store captured image
  CameraController? _cameraController;
  bool _isCameraInitialized =
      false; // Flag to check if the camera is initialized

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Method to initialize the camera
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras(); // Get available cameras
    // Create a CameraController to manage camera operations
    _cameraController = CameraController(cameras.first, ResolutionPreset.high);

    // Initialize the camera controller
    await _cameraController?.initialize();

    setState(() {
      _isCameraInitialized = true; // Update state once camera is initialized
    });
  }

  // Method to capture an image from the camera
  Future<void> _captureImage() async {
    // Ensure the camera is initialized before capturing an image
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        // Take a picture and get the image as an XFile
        final XFile image = await _cameraController!.takePicture();
        setState(() {
          _image = File(
              image.path); // Save the captured image to the _image variable
        });

        // Load your machine learning model (e.g., TensorFlow Lite, ML Kit)
        // For example:
        // final result = await yourModel.predict(_image);

        // Preprocess the captured image if necessary (resize, normalize, etc.)
        // Example: final processedImage = preprocessImage(_image);

        // Use the model to make predictions on the processed image
        // If a face is recognized, proceed accordingly
      } catch (e) {
        print(
            'Error capturing image: $e'); // Handle any errors during image capture
      }
    }
  }

  // Continue to registration page after capturing an image
  void continueToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose(); // Dispose of the camera controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color of the screen
      body: Stack(
        children: <Widget>[
          _isCameraInitialized
              ? CameraPreview(_cameraController!) // Display the camera preview
              : const Center(
                  child:
                      CircularProgressIndicator()), // Show loading indicator if camera is not initialized
          Positioned(
            top: 4,
            left: 20,
            child: CustomBackButton(
              onPressed: () {
                // Navigate back to the start page
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
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: ElevatedButton(
              onPressed: _captureImage, // Capture image when button is pressed
              child:
                  const Icon(Icons.camera_alt, size: 30, color: Colors.white),
            ),
          ),
          Positioned(
            top: 4,
            right: 20,
            child: ContinueButton(
              onPressed: continueToRegister, // Navigate to registration page
            ),
          ),
        ],
      ),
    );
  }
}
