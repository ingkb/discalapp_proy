class Student {
  Student({
        this.id,
        this.userId,
        this.name,
        this.age,
        this.password,
    });

    String id;
    String userId;
    String name;
    String password;
    int age;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        password: json["password"],
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "name": name,
        "password": password,
        "age":age
    };
}
