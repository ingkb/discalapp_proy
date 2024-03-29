class AreaResult {
    AreaResult({
         this.sesionId,
         this.area,
         this.resultado,
         this.tiempo,
         this.preguntas
    });

    String? sesionId;
    String? area;
    double? resultado;
    double? tiempo;
    int? preguntas;

    
    factory AreaResult.fromJson(Map<String, dynamic> json) => AreaResult(
        sesionId: json["sesionId"],
        area: json["area"],
        resultado: json["resultado"].toDouble(),
        tiempo: json["tiempo"].toDouble(),
        preguntas: json["preguntas"],
    );

    Map<String, dynamic> toJson() => {
        "sesionId": sesionId,
        "area": area,
        "resultado": resultado,
        "tiempo": tiempo,
        "preguntas":preguntas
    };
}