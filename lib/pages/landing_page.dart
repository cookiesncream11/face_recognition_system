import 'package:flutter/material.dart';
import 'dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facial Recognition App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const IntroPage(),
    );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 80.0,
              right: 80.0,
              bottom: 0,
              top: 100,
            ),
            child: Image.asset('lib/images/qr-scan.png'),
          ),
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Know your place',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Recognize();
                },
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(20),
              width: 300,
              child: const Center(
                child: Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
