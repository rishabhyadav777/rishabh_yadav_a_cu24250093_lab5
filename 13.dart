import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReadScreen(),
  ));
}

class ReadScreen extends StatefulWidget {
  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  String text = '';

  Future<void> readFile() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/data.txt');

    if (await file.exists()) {
      String data = await file.readAsString();

      setState(() {
        text = data;
      });
    } else {
      setState(() {
        text = 'File not found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Read File')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: readFile,
              child: Text('Read File'),
            ),
            SizedBox(height: 20),
            Text(text),
          ],
        ),
      ),
    );
  }
}