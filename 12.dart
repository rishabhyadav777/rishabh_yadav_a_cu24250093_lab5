import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FileScreen(),
  ));
}

class FileScreen extends StatefulWidget {
  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  Future<void> saveFile() async {
    final directory = await getApplicationDocumentsDirectory();

    final file = File('${directory.path}/data.txt');

    await file.writeAsString('Hello Flutter');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('File Saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Storage')),
      body: Center(
        child: ElevatedButton(
          onPressed: saveFile,
          child: Text('Save Text'),
        ),
      ),
    );
  }
}
