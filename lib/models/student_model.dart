class Student {
  Student({
        this.userId,
        this.name,
        this.password,
        this.age,
    });

    String userId;
    String name;
    String password;
    int age;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
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
