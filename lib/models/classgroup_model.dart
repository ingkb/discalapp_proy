class Classgroup {
   Classgroup({
        this.code,
        this.name,
        this.teacher,
    });
    String code;
    String name;
    String teacher;

    factory Classgroup.fromJson(Map<String, dynamic> json) => Classgroup(
        code: json["code"],
        name: json["name"],
        teacher: json["teacher"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "teacher": teacher,
    };
}
