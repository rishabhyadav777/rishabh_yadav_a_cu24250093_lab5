import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
  ));
}

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool firstLaunch = true;

  @override
  void initState() {
    super.initState();
    checkLaunch();
  }

  Future<void> checkLaunch() async {
    final prefs = await SharedPreferences.getInstance();

    bool opened = prefs.getBool('opened') ?? false;

    setState(() {
      firstLaunch = !opened;
    });

    if (!opened) {
      await prefs.setBool('opened', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Launch')),
      body: Center(
        child: Text(
          firstLaunch ? 'Welcome to the App!' : 'Welcome Back!',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}