import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(DarkApp());
}

class DarkApp extends StatefulWidget {
  @override
  State<DarkApp> createState() => _DarkAppState();
}

class _DarkAppState extends State<DarkApp> {
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    loadMode();
  }

  Future<void> loadMode() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> changeMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      darkMode = value;
    });

    await prefs.setBool('darkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: Text('Dark Mode')),
        body: Center(
          child: Switch(
            value: darkMode,
            onChanged: changeMode,
          ),
        ),
      ),
    );
  }
}