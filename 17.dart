import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StudentProfile(),
  ));
}

class StudentProfile extends StatefulWidget {
  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final name = TextEditingController();
  final roll = TextEditingController();
  final course = TextEditingController();
  final semester = TextEditingController();

  String savedName = '';
  String savedRoll = '';
  String savedCourse = '';
  String savedSemester = '';

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', name.text);
    await prefs.setString('roll', roll.text);
    await prefs.setString('course', course.text);
    await prefs.setString('semester', semester.text);

    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      savedName = prefs.getString('name') ?? '';
      savedRoll = prefs.getString('roll') ?? '';
      savedCourse = prefs.getString('course') ?? '';
      savedSemester = prefs.getString('semester') ?? '';
    });
  }

  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('name');
    await prefs.remove('roll');
    await prefs.remove('course');
    await prefs.remove('semester');

    name.clear();
    roll.clear();
    course.clear();
    semester.clear();

    setState(() {
      savedName = '';
      savedRoll = '';
      savedCourse = '';
      savedSemester = '';
    });
  }

  void editProfile() {
    name.text = savedName;
    roll.text = savedRoll;
    course.text = savedCourse;
    semester.text = savedSemester;
  }

  Widget field(
      TextEditingController controller,
      String label,
      ) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              field(name, 'Name'),
              field(roll, 'Roll Number'),
              field(course, 'Course'),
              field(semester, 'Semester'),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: saveProfile,
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: editProfile,
                    child: Text('Edit'),
                  ),
                  ElevatedButton(
                    onPressed: clearProfile,
                    child: Text('Clear'),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Card(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        'Saved Profile',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Name: $savedName'),
                      Text('Roll Number: $savedRoll'),
                      Text('Course: $savedCourse'),
                      Text('Semester: $savedSemester'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}