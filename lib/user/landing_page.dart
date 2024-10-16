import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
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
    return const MaterialApp(
      home: GetStartedPage(),
    );
  }
}

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  GetStartedPageState createState() => GetStartedPageState(); // Changed here
}

class GetStartedPageState extends State<GetStartedPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('lib/images/fdsap.mp4')
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _controller.play(); // Start playing the video
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

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
          // Video Background
          _controller.value.isInitialized
              ? SizedBox.expand(
                  child: VideoPlayer(_controller),
                )
              : const Center(
                  child: CircularProgressIndicator()), // Show loading indicator

          // Centered Content
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
                  totalRepeatCount: 5,
                  pause: const Duration(milliseconds: 500),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: false,
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
                      horizontal: 50,
                      vertical: 15,
                    ),
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
          // Rotated Text
          Positioned(
            top: 50,
            right: -30,
            child: Column(
              children: [
                Transform.rotate(
                  angle: -270 * 3.14159 / 180,
                  child: const Text(
                    'We Listen',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF630606),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 120),
                Transform.rotate(
                  angle: -270 * 3.14159 / 180,
                  child: const Text(
                    'We Anticipate',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF630606),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 120),
                Transform.rotate(
                  angle: -270 * 3.14159 / 180,
                  child: const Text(
                    'We Deliver',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF630606),
                      fontWeight: FontWeight.bold,
                    ),
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
