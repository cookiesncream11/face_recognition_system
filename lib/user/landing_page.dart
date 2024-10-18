import 'package:flutter/material.dart';
import 'camera.dart';
import '../admin-panel/login_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GetStartedPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  GetStartedPageState createState() => GetStartedPageState();
}

class GetStartedPageState extends State<GetStartedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Setup
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();

    _rotationAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Color with Image
          Container(
            color: Colors.white, // Set the background color to red
            child: Center(
              child: Image.asset(
                'lib/images/background/8.png', // Path to your background image
                fit: BoxFit.cover,
                width: screenWidth,
                height: screenHeight,
              ),
            ),
          ),

          // Centered Content
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth > 600 ? 150.0 : 50.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: screenHeight * 0.1, // Prevent overflow
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100), // Move down the content
                    Image.asset(
                      'lib/images/indian.jpg',
                      height: screenWidth > 600 ? 250 : 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 30),

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
                      totalRepeatCount: 100,
                      pause: const Duration(milliseconds: 500),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: false,
                    ),

                    const SizedBox(height: 20),

                    // Responsive Button
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth > 600 ? 300 : 200,
                        minWidth: 200,
                      ),
                      child: ElevatedButton(
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
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Rotating Image (Top Left Corner)
          Positioned(
            top: -40,
            left: -40,
            child: RotationTransition(
              turns: _rotationAnimation,
              child: Image.asset(
                'lib/images/bilog.png',
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Admin Icon
          Positioned(
            top: 5,
            right: 0,
            child: IconButton(
              icon: Image.asset(
                'lib/images/add-user.png',
                height: 24,
                width: 24,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Admin(),
                  ),
                );
              },
            ),
          ),

          // (We Listen, We Anticipate, We Deliver)
          Positioned(
            top: 120,
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
                        fontWeight: FontWeight.bold),
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
                        fontWeight: FontWeight.bold),
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
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Additional Background Image (Bottom Left)
          Positioned(
            bottom: 20,
            left: 20,
            child: Image.asset(
              'lib/images/background/4.png', // Adjust this path as necessary
              height: 100, // Adjust the size as needed
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
