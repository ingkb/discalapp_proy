class Student {
  Student(
      {this.userId,
      this.name,
      this.password,
      this.age,
      this.classgroup,
      this.grade});

  String? userId;
  String? name;
  String? password;
  String? classgroup;
  int? grade;
  int? age;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      userId: json["userId"],
      name: json["name"],
      password: json["password"],
      age: json["age"],
      classgroup: json["classgroup"],
      grade: json["grade"]);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "password": password,
        "age": age,
        "classgroup": classgroup,
        "grade": grade,
      };
}
