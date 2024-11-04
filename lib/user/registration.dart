import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart'; // Import the package
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
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  String? _imagePath;

  // List of job titles
  final List<String> _jobTitles = [
    'Software Engineer',
    'Project Manager',
    'Data Analyst',
    'UI/UX Designer',
    'System Administrator',
    'HR Manager',
  ];

  // Selected job title
  String? _selectedJobTitle;

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

  Future<void> _registerEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> pendingList = prefs.getStringList('pending_employees') ?? [];
    String employeeData =
        '${_nameController.text},${_selectedJobTitle ?? 'N/A'}'; // No ID here for pending
    pendingList.add(employeeData); // Add to pending list
    await prefs.setStringList('pending_employees', pendingList);

    // Create a notification for the new registration
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    notifications.add('New registration: $employeeData');
    await prefs.setStringList('notifications', notifications);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Registration submitted for: ${_nameController.text}, Job: ${_selectedJobTitle ?? 'N/A'}',
        ),
      ),
    );

    // Clear text fields after registration
    _nameController.clear();
    setState(() {
      _selectedJobTitle = null; // Reset dropdown
    });
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
                  width: 300,
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    value: _selectedJobTitle,
                    hint: const Text('Select Job Title'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedJobTitle = newValue;
                      });
                    },
                    items: _jobTitles
                        .map<DropdownMenuItem<String>>((String jobTitle) {
                      return DropdownMenuItem<String>(
                        value: jobTitle,
                        child: Text(jobTitle),
                      );
                    }).toList(),
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
                onPressed: _captureImage,
              ),
              const SizedBox(height: 16),
              _imagePath != null ? Image.file(File(_imagePath!)) : Container(),
              SizedBox(height: 16),
              SendButton(
                onPressed: _registerEmployee, // Call the new function
              ),
            ],
          ),
        ),
      ),
    );
  }
}
