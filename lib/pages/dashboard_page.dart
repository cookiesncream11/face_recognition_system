import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'landing_page.dart';

class Recognize extends StatefulWidget {
  const Recognize({Key? key}) : super(key: key);

  @override
  State<Recognize> createState() => _RecognizeState();
}

class _RecognizeState extends State<Recognize> {
  File? _image; // Variable to hold the selected/captured image
  final ImagePicker _picker = ImagePicker();

  Future<void> chooseImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path); // Set the selected image
      });
    }
  }

  Future<void> captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path); // Set the captured image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder:
                  (context) => const IntroPage()),
                  (route) => false, // This clears the stack
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the selected or captured image
            _image != null
                ? Image.file(_image!, height: 150) // Display the image
                : const Icon(Icons.image, size: 150), // Default icon

            const SizedBox(height: 20), // Add some space

            ElevatedButton(
              onPressed: chooseImage, // Call chooseImage on press
              onLongPress: captureImage, // Call captureImage on long press
              child: const Text("Choose Picture"),
            ),
          ],
        ),
      ),
    );
  }
}

