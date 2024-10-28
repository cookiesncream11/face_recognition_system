import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await someAsyncOperation();

            if (!mounted) return;
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NextPage(),
            ));
          },
          child: const Text('Register'),
        ),
      ),
    );
  }

  Future<void> someAsyncOperation() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: const Center(child: Text('Welcome!')),
    );
  }
}
