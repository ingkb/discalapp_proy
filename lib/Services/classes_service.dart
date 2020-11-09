import 'dart:convert';
import 'package:discalapp_proy/models/classgroup_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class ClassgroupService{

  Future<RegisterClassgroupResponse> addClassgroup(Classgroup classgroup) async{
    final http.Response response = await http.post(BaseUrl+'/classgroups', 
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
    final response = await http.get(BaseUrl+'/classgroups/'+code);


    if(response.statusCode == 200){
      return SearchClassgroupResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar clase');
    }
  }

  Future<SearchAllClassgroupResponse> getAllClassgroup() async{
    final response = await http.get(BaseUrl+'/classgroups');

    if(response.statusCode == 200){
      return SearchAllClassgroupResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar clase');
    }
  }

  Future<RegisterClassgroupResponse> deleteClassgroup(String code) async{
    final http.Response response = await http.delete(BaseUrl+'/classgroups/'+code, 
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
    final http.Response response = await http.patch(BaseUrl+'/classgroups/'+code, 
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
        this.classgroups,
    });

    List<Classgroup> classgroups;

    factory SearchAllClassgroupResponse.fromJson(Map<String, dynamic> json) => SearchAllClassgroupResponse(
        classgroups: List<Classgroup>.from(json["classgroups"].map((x) => Classgroup.fromJson(x))),
    );
}

class SearchClassgroupResponse {
    SearchClassgroupResponse({
        this.message,
        this.classgroup,
    });

    String message;
    Classgroup classgroup;

    factory SearchClassgroupResponse.fromJson(Map<String, dynamic> json) => SearchClassgroupResponse(
        message: json["message"],
        classgroup: Classgroup.fromJson(json["classgroup"]),
    );
}

class RegisterClassgroupResponse {
    RegisterClassgroupResponse({
        this.message,
    });

    String message;

    factory RegisterClassgroupResponse.fromJson(Map<String, dynamic> json) => RegisterClassgroupResponse(
        message: json["message"],
    );
}



