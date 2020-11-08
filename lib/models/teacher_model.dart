class Teacher {
   Teacher({
        this.id,
        this.userId,
        this.name,
        this.password,
    });

    String id;
    String userId;
    String name;
    String password;

    factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "name": name,
        "password": password,
    };
}
