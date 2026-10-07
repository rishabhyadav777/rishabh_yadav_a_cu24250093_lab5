import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student {
  String name;
  String rollNo;
  String course;

  Student(this.name, this.rollNo, this.course);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rollNo': rollNo,
      'course': course,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      map['name'],
      map['rollNo'],
      map['course'],
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StudentScreen(),
  ));
}

class StudentScreen extends StatefulWidget {
  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  String result = '';

  Future<void> saveStudent() async {
    final prefs = await SharedPreferences.getInstance();

    Student student = Student('Rishabh', '101', 'BCA');

    String jsonData = jsonEncode(student.toMap());

    await prefs.setString('student', jsonData);

    setState(() {
      result = jsonData;
    });
  }

  Future<void> loadStudent() async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonData = prefs.getString('student');

    if (jsonData != null) {
      Map<String, dynamic> map = jsonDecode(jsonData);

      Student student = Student.fromMap(map);

      setState(() {
        result =
        '${student.name}\n${student.rollNo}\n${student.course}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student JSON')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: saveStudent,
              child: Text('Save Student'),
            ),
            ElevatedButton(
              onPressed: loadStudent,
              child: Text('Load Student'),
            ),
            SizedBox(height: 20),
            Text(result),
          ],
        ),
      ),
    );
  }
}