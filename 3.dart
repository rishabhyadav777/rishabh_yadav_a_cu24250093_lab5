import 'dart:convert';

void main() {
  Map<String, dynamic> student = {
    'name': 'Rishabh',
    'rollNo': 101,
    'course': 'BCA',
  };

  String jsonData = jsonEncode(student);

  print('JSON: $jsonData');

  Map<String, dynamic> newStudent = jsonDecode(jsonData);

  print(newStudent);
}