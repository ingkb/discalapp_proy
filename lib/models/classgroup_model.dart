class Classgroup {
   Classgroup({
         this.code,
         this.name,
         this.teacher,
         this.grade
    });
    String? code;
    String? name;
    String? teacher;
    int? grade;

    factory Classgroup.fromJson(Map<String, dynamic> json) => Classgroup(
        code: json["code"],
        name: json["name"],
        teacher: json["teacher"],
        grade: json["grade"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "teacher": teacher,
        "grade": grade,
    };
}
