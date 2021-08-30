import 'dart:convert';
import 'package:discalapp_proy/models/areaResult_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class GeneralAreaService{

  Future<CompareGeneralAreaResponse> compararResultado(CompareGeneralAreaRequest areaResult) async{
    var url = Uri.parse(BaseUrl+'/generalArea');
    final http.Response response = await http.post(url, 
      body: json.encode(areaResult.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 201){
      return CompareGeneralAreaResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al agregar clase');
    }
  }
}

class CompareGeneralAreaResponse {
    CompareGeneralAreaResponse(
         this.state,
         this.test,
         this.areaResults,
    );

    int? state;
    String? test;
    List<AreaResult>? areaResults;

    
    factory CompareGeneralAreaResponse.fromJson(Map<String, dynamic> json) => CompareGeneralAreaResponse(
        json["state"],
        json["test"],
        List<AreaResult>.from(json["areaResults"].map((x) => AreaResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "state": state,
        "test": test,
        "areaResults": areaResults,
    };
}

class CompareGeneralAreaRequest {
    CompareGeneralAreaRequest(
         this.sesionId,
         this.student,
         this.inicial
    );

    String sesionId;
    String student;
    bool inicial;
    
    factory CompareGeneralAreaRequest.fromJson(Map<String, dynamic> json) => CompareGeneralAreaRequest(
        json["sesionId"],
        json["student"],
        json["inicial"],
    );

    Map<String, dynamic> toJson() => {
        "sesionId": sesionId,
        "student": student,
        "inicial": inicial,
    };
}


