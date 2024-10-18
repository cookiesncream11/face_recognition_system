import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'landing_page.dart';
import '../user/registration.dart';

class Recognize extends StatefulWidget {
  const Recognize({super.key});

  @override
  State<Recognize> createState() => _RecognizeState();
}

class _RecognizeState extends State<Recognize> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> chooseImage() async {
    // Use file_picker for web
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }

  Future<void> scanImage() async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Camera scan is not available on the web."),
        ),
      );
      return;
    }

    // Use image_picker for mobile
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void continueToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const RegistrationPage()), // Update with your registration page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            const SizedBox(height: 20),
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
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: scanImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF250000),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Scan"),
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
