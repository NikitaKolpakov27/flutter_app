void main() {
 var Kolpakov = Student('Nikita', 'Kolpakov', [5, 4, 5, 4, 4]);
 print(Kolpakov.grades);
}

class Student {
  String name;
  String lastName;
  List<int> grades;

  Student(this.name, this.lastName, this.grades);

}