import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'landing_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Camera capture is not available on the web.")),
      );
      return;
    }

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
      backgroundColor: Colors.white, // Set the background color to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GetStartedPage()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20), // Space between button and content
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(75),
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
                            color: Colors.grey,
                          ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200, // Fixed width for buttons
                      height: 50, // Fixed height for buttons
                      child: ElevatedButton(
                        onPressed: chooseImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xFF250000), // Button background color
                          foregroundColor: Colors.white, // Button text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Choose from Gallery"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200, // Fixed width for buttons
                      height: 50, // Fixed height for buttons
                      child: ElevatedButton(
                        onPressed: captureImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xFF250000), // Button background color
                          foregroundColor: Colors.white, // Button text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Capture Image"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
