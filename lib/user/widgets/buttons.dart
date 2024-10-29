import 'package:flutter/material.dart';

// Custom Back Button Class
class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:
          const Icon(Icons.arrow_back, color: Colors.black), // Changed to black
      onPressed: onPressed,
    );
  }
}

//scan.dart  register button
class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text("Continue to Register"),
      ),
    );
  }
}

// Capture Button Class
class CaptureButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CaptureButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Different color for distinction
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Different radius
          ),
        ),
        child: const Text("Capture Image"),
      ),
    );
  }
}

// registration.dart Send Button
class SendButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SendButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange, // Different color for distinction
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text("Send"), // Button text
      ),
    );
  }
}
