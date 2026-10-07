import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ClearScreen(),
  ));
}

class ClearScreen extends StatefulWidget {
  @override
  State<ClearScreen> createState() => _ClearScreenState();
}

class _ClearScreenState extends State<ClearScreen> {
  String name = '';

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', 'Rishabh');

    setState(() {
      name = 'Rishabh';
    });
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    setState(() {
      name = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clear Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: $name'),
            ElevatedButton(
              onPressed: saveData,
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: clearData,
              child: Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}