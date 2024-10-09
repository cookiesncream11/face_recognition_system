import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Recognize extends StatefulWidget {
  const Recognize({Key? key}) : super(key: key);

  @override
  State<Recognize> createState() => _RecognizeState();
}

class _RecognizeState extends State<Recognize> {
  // File? _image; // Uncomment this if you want to handle image files
  final ImagePicker _picker = ImagePicker();

  void chooseImage() async {
    // Use the ImagePicker to choose an image from the gallery
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        // _image = File(image.path); // Uncomment if using File
      });
    }
  }

  void captureImage() async {
    // Use the ImagePicker to capture an image from the camera
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        // _image = File(image.path); // Uncomment if using File
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Recognize Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Uncomment to display the selected/captured image
            // _image != null ? Image.file(_image!) : Icon(Icons.image, size: 150),
            ElevatedButton(
              onPressed: chooseImage,
              onLongPress: captureImage,
              child: const Text("Choose Picture"),
            ),
          ],
        ),
      ),
    );
  }
}
