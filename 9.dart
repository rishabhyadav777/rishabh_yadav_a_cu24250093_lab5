import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SubjectScreen(),
  ));
}

class SubjectScreen extends StatefulWidget {
  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  List<String> subjects = [];

  @override
  void initState() {
    super.initState();
    loadSubjects();
  }

  Future<void> loadSubjects() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      subjects = prefs.getStringList('subjects') ?? [];
    });
  }

  Future<void> saveSubjects() async {
    final prefs = await SharedPreferences.getInstance();

    subjects.add('Flutter');

    await prefs.setStringList('subjects', subjects);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourite Subjects')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: saveSubjects,
            child: Text('Add Flutter'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(subjects[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}