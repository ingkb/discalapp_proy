class Student {
  Student({
        this.id,
        this.userId,
        this.name,
        this.password,
        this.age,
    });

    String id;
    String userId;
    String name;
    String password;
    int age;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        password: json["password"],
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "password": password,
        "age": age,
    };
}
