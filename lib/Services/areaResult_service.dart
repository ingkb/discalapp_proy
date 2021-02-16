import 'dart:convert';
import 'package:discalapp_proy/models/areaResult_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class AreaResultService{

  Future<RegisterAreaResultResponse> addAreaResult(AreaResult areaResult) async{
    final http.Response response = await http.post(BaseUrl+'/areaResults', 
      body: json.encode(areaResult.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if(response.statusCode == 201){
      return RegisterAreaResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al agregar areaResult');
    }
  }

   Future<SearchAreaResultResponse> getAreaResult(String code) async{
    final response = await http.get(BaseUrl+'/areaResults/'+code);


    if(response.statusCode == 200){
      return SearchAreaResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar areaResult');
    }
  }

  Future<SearchAllAreaResultResponse> getAllAreaResult(String studentId) async{
    final response = await http.get(BaseUrl+'/areaResults/student/'+studentId);

    if(response.statusCode == 200){
      return SearchAllAreaResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar areaResult');
    }
  }

  Future<RegisterAreaResultResponse> deleteAreaResult(String code) async{
    final http.Response response = await http.delete(BaseUrl+'/areaResults/'+code, 
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return RegisterAreaResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al eliminar areaResult');
    }
  }

  Future<RegisterAreaResultResponse> updateAreaResult(String code, AreaResult areaResult) async{
    final http.Response response = await http.patch(BaseUrl+'/areaResults/'+code, 
     body: json.encode(areaResult.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return RegisterAreaResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al eliminar areaResult');
    }
  }
}

class SearchAllAreaResultResponse {
    SearchAllAreaResultResponse({
        this.state,
        this.areaResults,
    });

    int state;
    List<AreaResult> areaResults;

    factory SearchAllAreaResultResponse.fromJson(Map<String, dynamic> json) => SearchAllAreaResultResponse(
        state: json["state"],
        areaResults: List<AreaResult>.from(json["areaResults"].map((x) => AreaResult.fromJson(x))),
    );
}

class SearchAreaResultResponse {
    SearchAreaResultResponse({
        this.state,
        this.message,
        this.areaResult,
    });

    int state;
    String message;
    AreaResult areaResult;

    factory SearchAreaResultResponse.fromJson(Map<String, dynamic> json) => SearchAreaResultResponse(
        state: json["state"],
        message: json["message"],
        areaResult: json["areaResult"] == null ? null : AreaResult.fromJson(json["areaResult"]),
    
    );
}

class RegisterAreaResultResponse {
    RegisterAreaResultResponse({
        this.state,
        this.message,
    });
    int state;
    String message;

    factory RegisterAreaResultResponse.fromJson(Map<String, dynamic> json) => RegisterAreaResultResponse(
       state: json["state"],
       message: json["message"],
    );
}



