class Student {
  String name;
  double grade;

  Student(this.name, this.grade);

  bool hasPassed() {
    if (grade>=10) {
      return true;
    } else {
      return false;
    }
  }
}



void main() {
  Student student1 = Student("Lobna", 15.5);
  Student student2 = Student("Jomana", 15);
  Student student3 = Student("Linda", 9.5);
  


List<Student> myStudents = [student1, student2, student3];
  
  double sum = 0;


   for (var student in myStudents) {
    sum += student.grade;
    String status = student.hasPassed() ? "PASSED" : "FAILED";
     print("Name:${student.name}, Grade: ${student.grade} -> $status");
   
   }
   double average = sum / myStudents.length;
   print("\nClass Average: ${average.toStringAsFixed(2)}");
   
   } 
