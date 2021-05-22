class Teacher {
   Teacher({
         this.userId,
         this.name,
         this.password,
         this.id,
    });
    String? id;
    String? userId;
    String? name;
    String? password;

    factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "password": password,
    };
}
