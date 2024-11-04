import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import '../user/scan.dart';
import '../user/widgets/buttons.dart';

void main() => runApp(RegistrationPage());

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Registration',
      debugShowCheckedModeBanner: false,
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
          _imagePath = image.path;
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
      appBar: AppBar(
        title: const Text('Register Employee'),
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Recognize()),
              (route) => false,
            );
          },
        ),
      ),
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
              const SizedBox(height: 16),
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
                          width: 400,
                          height: 400,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: CameraPreview(_cameraController!),
                          ),
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 16),
              CaptureButton(
                // Use the new CaptureButton
                onPressed: _captureImage,
              ),
              const SizedBox(height: 16),
              _imagePath != null
                  ? Image.file(File(_imagePath!)) // Display captured image
                  : Container(),
              SizedBox(height: 16),
              SendButton(
                // Use the new SendButton
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Registered: ${_nameController.text}, Job: ${_jobController.text}')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
