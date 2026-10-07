import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NotesScreen(),
  ));
}

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final controller = TextEditingController();

  List<String> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/notes.json');
  }

  Future<void> saveNotes() async {
    final file = await getFile();

    await file.writeAsString(jsonEncode(notes));
  }

  Future<void> loadNotes() async {
    final file = await getFile();

    if (await file.exists()) {
      String data = await file.readAsString();

      setState(() {
        notes = List<String>.from(jsonDecode(data));
      });
    }
  }

  void addNote() {
    if (controller.text.isNotEmpty) {
      setState(() {
        notes.add(controller.text);
        controller.clear();
      });

      saveNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter Note',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: addNote,
            child: Text('Save Note'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}