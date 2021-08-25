import 'dart:convert';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/models/teacher_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class StudentService{

  Future<SearchStudentsResponse> getClassStudents(String classgroupCode) async{
    var url = Uri.parse(BaseUrl+'/students/classgroup/'+classgroupCode);
    final response = await http.get(url);

    if(response.statusCode == 200){
      return SearchStudentsResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar clase');
    }
  }

  Future<DefaultResponse> upadateStudent(Student student) async{
    var url = Uri.parse(BaseUrl+'/students/'+student.userId!);
    final http.Response response = await http.patch(url, 
      body: json.encode(student.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return DefaultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al iniciar sesion');
    }
  }

  Future<DefaultResponse> registerTeacher(Teacher teacher) async{
    var url = Uri.parse(BaseUrl+'/teachers');
    final http.Response response = await http.post(url, 
      body: json.encode(teacher.toJson()),
       headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 201){
      return DefaultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al iniciar sesion');
    }
  }

}

class DefaultResponse {
    DefaultResponse({
        this.state,
        this.message,
    });

    int? state;
    String? message;
    factory DefaultResponse.fromJson(Map<String, dynamic> json) => DefaultResponse(
        state: json["state"],
        message: json["message"]
    );
}

class SearchStudentsResponse{

  SearchStudentsResponse({
    this.state,
    this.students
  });

  int? state;
  List<Student>? students;

   factory SearchStudentsResponse.fromJson(Map<String, dynamic> json) => SearchStudentsResponse(
        state: json["state"],
        students: List<Student>.from(json["students"].map((x) => Student.fromJson(x))),
    );
}


