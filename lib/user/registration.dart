import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

void main() => runApp(RegistrationPage());

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Registration',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EmployeeRegistrationScreen(),
    );
  }
}

class EmployeeRegistrationScreen extends StatefulWidget {
  @override
  _EmployeeRegistrationScreenState createState() =>
      _EmployeeRegistrationScreenState();
}

class _EmployeeRegistrationScreenState
    extends State<EmployeeRegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  String? _imagePath;

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
          _imagePath = image.path; // Save the captured image path
        });
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
      appBar: AppBar(title: const Text('Register Employee')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 300, // Set width for the TextField
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  width: 300, // Set width for the TextField
                  child: TextField(
                    controller: _jobController,
                    decoration: const InputDecoration(labelText: 'Job Title'),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _isCameraInitialized
                  ? Center(
                      child: ClipOval(
                        child: Container(
                          width: 400, // Increased width for a larger circle
                          height: 400, // Increased height to match width
                          child: AspectRatio(
                            aspectRatio: 1, // Keep it square for circular shape
                            child: CameraPreview(_cameraController!),
                          ),
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _captureImage,
                child: const Text('Capture Image'),
              ),
              SizedBox(height: 16),
              _imagePath != null
                  ? Image.file(File(_imagePath!)) // Display captured image
                  : Container(),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Registered: ${_nameController.text}, Job: ${_jobController.text}')),
                  );
                },
                child: const Text('Register Employee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
