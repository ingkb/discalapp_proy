import 'dart:convert';
import 'package:discalapp_proy/models/classgroup_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class ClassgroupService{

  Future<RegisterClassgroupResponse> addClassgroup(Classgroup classgroup) async{
    var url = Uri.parse(BaseUrl+'/classgroups');
    final http.Response response = await http.post(url, 
      body: json.encode(classgroup.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if(response.statusCode == 201){
      return RegisterClassgroupResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al agregar clase');
    }
  }

   Future<SearchClassgroupResponse> getClassgroup(String code) async{
     var url = Uri.parse(BaseUrl+'/classgroups/'+code);
    final response = await http.get(url);


    if(response.statusCode == 200){
      return SearchClassgroupResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar clase');
    }
  }

  Future<SearchAllClassgroupResponse> getAllClassgroup(String teacherId) async{
    var url = Uri.parse(BaseUrl+'/classgroups/teacher/'+teacherId);
    final response = await http.get(url);

    if(response.statusCode == 200){
      return SearchAllClassgroupResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar clase');
    }
  }

  Future<RegisterClassgroupResponse> deleteClassgroup(String code) async{
    var url = Uri.parse(BaseUrl+'/classgroups/'+code);
    final http.Response response = await http.delete(url, 
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return RegisterClassgroupResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al eliminar clase');
    }
  }

  Future<RegisterClassgroupResponse> updateClassgroup(String code, Classgroup classgroup) async{
    var url = Uri.parse(BaseUrl+'/classgroups/'+code);
    final http.Response response = await http.patch(url, 
     body: json.encode(classgroup.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return RegisterClassgroupResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al eliminar clase');
    }
  }
}

class SearchAllClassgroupResponse {
    SearchAllClassgroupResponse({
        this.state,
        this.classgroups,
    });

    int? state;
    List<Classgroup>? classgroups;

    factory SearchAllClassgroupResponse.fromJson(Map<String, dynamic> json) => SearchAllClassgroupResponse(
        state: json["state"],
        classgroups: List<Classgroup>.from(json["classgroups"].map((x) => Classgroup.fromJson(x))),
    );
}

class SearchClassgroupResponse {
    SearchClassgroupResponse({
        this.state,
        this.message,
        this.classgroup,
    });

    int? state;
    String? message;
    Classgroup? classgroup;

    factory SearchClassgroupResponse.fromJson(Map<String, dynamic> json) => SearchClassgroupResponse(
        state: json["state"],
        message: json["message"],
        classgroup: json["classgroup"] == null ? null : Classgroup.fromJson(json["classgroup"]),
    
    );
}

class RegisterClassgroupResponse {
    RegisterClassgroupResponse({
        this.state,
        this.message,
    });
    int? state;
    String? message;

    factory RegisterClassgroupResponse.fromJson(Map<String, dynamic> json) => RegisterClassgroupResponse(
       state: json["state"],
        message: json["message"],
    );
}



