import 'dart:convert';
import 'package:discalapp_proy/models/areaResult_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class AreaResultService{

  Future<RegisterAreaResultResponse> addAreaResult(AreaResult areaResult) async{
    var url = Uri.parse(BaseUrl+'/areaResult');
    final http.Response response = await http.post(url, 
      body: json.encode(areaResult.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if(response.statusCode == 201){
      return RegisterAreaResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al agregar clase');
    }
  }

   Future<SearchAllAreaResultResponse> getAreaResultsBySesion(String sesionId) async{
     var url = Uri.parse(BaseUrl+'/areaResult/sesion/'+sesionId);
    final response = await http.get(url);


    if(response.statusCode == 200){
      return SearchAllAreaResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar clase');
    }
  }

  Future<RegisterAreaResultResponse> deleteAreaResult(String code) async{
    var url = Uri.parse(BaseUrl+'/areaResult/'+code);
    final http.Response response = await http.delete(url, 
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return RegisterAreaResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al eliminar clase');
    }
  }
}

class SearchAllAreaResultResponse {
    SearchAllAreaResultResponse({
        this.state,
        this.areaResults,
    });

    int? state;
    List<AreaResult>? areaResults;

    factory SearchAllAreaResultResponse.fromJson(Map<String, dynamic> json) => SearchAllAreaResultResponse(
        state: json["state"],
        areaResults: List<AreaResult>.from(json["areaResults"].map((x) => AreaResult.fromJson(x))),
    );
}

class RegisterAreaResultResponse {
    RegisterAreaResultResponse({
        this.state,
        this.message,
    });
    int? state;
    String? message;

    factory RegisterAreaResultResponse.fromJson(Map<String, dynamic> json) => RegisterAreaResultResponse(
       state: json["state"],
        message: json["message"],
    );
}



