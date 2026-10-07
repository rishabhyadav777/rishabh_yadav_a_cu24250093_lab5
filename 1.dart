void main() {
  Map<String, String> student = {
    'Name': 'Rishabh',
    'Roll No': '101',
    'Course': 'BCA',
  };

  student.forEach((key, value) {
    print('$key: $value');
  });
}