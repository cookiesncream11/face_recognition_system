import 'package:flutter/material.dart';
import 'camera.dart';
import '../admin-panel/login_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final double bottomHeight = 80.0;
  final double iconSpacing = 20.0;

  @override
  void initState() {
    super.initState();
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

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch the URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 20,
            child: Image.asset(
              'lib/images/background/14.png',
              height: 500,
              fit: BoxFit.cover,
            ),
          ),

          // Background Color with Image
          Container(
              //color: Colors.transparent,

              /*child: Center(
              child: Image.asset(
                'lib/images/background/bg.png',
                fit: BoxFit.cover,
                width: screenWidth,
                height: screenHeight,
              ),
            ),*/
              ),
          // Centered Content
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth > 600 ? 150.0 : 50.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: screenHeight * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Image.asset(
                      'lib/images/img/indian.jpg',
                      height: screenWidth > 600 ? 250 : 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 30),
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
                          backgroundColor: const Color(0xFFDD3333),
                          padding: const EdgeInsets.symmetric(vertical: 18),
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
                'lib/images/background/12.png',
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
                'lib/images/icon/admin_user.png',
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
          // Bottom Images

          Positioned(
            bottom: 10,
            left: 20,
            child: Image.asset(
              'lib/images/background/13.png',
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          // Bottom Center Icons
          Positioned(
            bottom: 2,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'lib/images/icon/world-wide-web.png',
                        height: 22,
                        width: 22,
                      ),
                      tooltip: 'Visit our FDS website',
                      onPressed: () {
                        _launchURL(
                            'https://fdsap-ph.fortress-asya.com/#/Homepage');
                      },
                    ),
                    SizedBox(width: iconSpacing),
                    IconButton(
                      icon: Image.asset(
                        'lib/images/icon/linkedin-logo.png',
                        height: 22,
                        width: 22,
                      ),
                      tooltip: 'View LinkedIn profile',
                      onPressed: () {
                        _launchURL('https://www.linkedin.com/in/yourprofile');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
