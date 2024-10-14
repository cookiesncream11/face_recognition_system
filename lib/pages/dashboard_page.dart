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
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> chooseImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0), // Lighter background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF6200EE), // Lighter AppBar color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const IntroPage()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'Image Recognizer',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(75), // Rounded corners
                    child: Image.file(
                      _image!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(
                    Icons.image,
                    size: 150,
                    color: Colors.grey, // Lighter icon color
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: chooseImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6200EE),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Choose from Gallery"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: captureImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6200EE),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Capture Image"),
            ),
          ],
        ),
      ),
    );
  }
}
