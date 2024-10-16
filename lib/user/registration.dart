import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Recognize(),
    );
  }
}

class Recognize extends StatefulWidget {
  const Recognize({Key? key}) : super(key: key);

  @override
  _RecognizeState createState() => _RecognizeState();
}

class _RecognizeState extends State<Recognize> {
  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> chooseImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _image = File(result.files.single.path!);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> captureImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image captured.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error capturing image: $e')),
      );
    }
  }

  void register() {
    final name = _nameController.text;
    final job = _jobController.text;

    if (name.isEmpty || job.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and choose an image.')),
      );
      return;
    }

    // Handle registration logic here (e.g., send data to server)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registration Successful: $name, $job')),
    );

    // Clear the fields
    _nameController.clear();
    _jobController.clear();
    setState(() {
      _image = null; // Reset the image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // Center the entire column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _jobController,
                decoration: const InputDecoration(labelText: 'Job Title'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the row
                children: [
                  SizedBox(
                    width: 150, // Fixed width for buttons
                    height: 50,
                    child: ElevatedButton(
                      onPressed: chooseImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF250000),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Choose from Gallery"),
                    ),
                  ),
                  const SizedBox(width: 16), // Space between buttons
                  SizedBox(
                    width: 150, // Fixed width for buttons
                    height: 50,
                    child: ElevatedButton(
                      onPressed: captureImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF250000),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Capture Image"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_image != null)
                Image.file(
                  _image!,
                  width: 100,
                  height: 100,
                ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF250000),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
