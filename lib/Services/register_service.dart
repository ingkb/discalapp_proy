import 'dart:convert';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/models/teacher_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class RegisterService{

  Future<StudentRegisterResponse> registerStudent(Student student) async{
    final http.Response response = await http.post(BaseUrl+'/student', 
      body: student.toJson()
    );

    if(response.statusCode == 201){
      return StudentRegisterResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al iniciar sesion');
    }
  }

  Future<TeacherRegisterResponse> registerTeacher(Teacher teacher) async{
    final http.Response response = await http.post(BaseUrl+'/teacher', 
      body: teacher.toJson()
    );

    if(response.statusCode == 201){
      return TeacherRegisterResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al iniciar sesion');
    }
  }

}

class StudentRegisterResponse {
    StudentRegisterResponse({
        this.message,
    });

    String message;

    factory StudentRegisterResponse.fromJson(Map<String, dynamic> json) => StudentRegisterResponse(
        message: json["message"],
    );
}

class TeacherRegisterResponse {
    TeacherRegisterResponse({
        this.message,
    });

    String message;

    factory TeacherRegisterResponse.fromJson(Map<String, dynamic> json) => TeacherRegisterResponse(
        message: json["message"],
    );
}


