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
  Student student = Student('Rishabh', '101', 'BCA');

  Map<String, dynamic> data = student.toMap();
  print(data);

  Student newStudent = Student.fromMap(data);

  print(newStudent.name);
  print(newStudent.rollNo);
  print(newStudent.course);
}