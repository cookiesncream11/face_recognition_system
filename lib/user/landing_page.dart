import 'package:flutter/material.dart';
import 'camera.dart';
import '../admin-panel/login_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: const GetStartedPage(),
    );
  }
}

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Image.asset(
              'lib/images/add-user.png', // Ensure this image exists
              height: 24,
              width: 24,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const Admin(), // Ensure this page exists
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Centered image
                Image.asset(
                  'lib/images/indian.jpg', // Ensure this image exists
                  height: 300,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),

                // Animated Text
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'FACE TUAH',
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF630606),
                      ),
                    ),
                  ],
                  totalRepeatCount: 5, // Repeat the animation 5 times
                  pause: const Duration(
                      milliseconds: 500), // Pause before starting again
                  displayFullTextOnTap:
                      true, // Tap to display full text immediately
                  stopPauseOnTap: false, // Stop pause on tap
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Recognize(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF250000),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50, // Adjust this value to position vertically
            right: -30, // Adjust this value to position horizontally
            child: Column(
              children: [
                Transform.rotate(
                  angle: -270 * 3.14159 / 180, // Rotate counter-clockwise
                  child: const Text(
                    'We Listen',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF630606),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 120),
                // Space between the lines
                Transform.rotate(
                  angle: -270 * 3.14159 / 180,
                  child: const Text(
                    'We Anticipate',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF630606),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 120), // Space between the lines
                Transform.rotate(
                  angle: -270 * 3.14159 / 180,
                  child: const Text(
                    'We Deliver',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF630606),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
