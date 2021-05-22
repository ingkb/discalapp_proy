class AreaResult {
    AreaResult({
         this.preguntas,
         this.aciertos,
         this.tiempo,
         this.area,
         this.sesionId
    });

    int? preguntas;
    int? aciertos;
    double? tiempo;
    String? sesionId;
    String? area;

    factory AreaResult.fromJson(Map<String, dynamic> json) => AreaResult(
        preguntas: json["preguntas"] == null ? null : json["preguntas"],
        aciertos: json["aciertos"] == null ? null : json["aciertos"],
        tiempo: json["tiempo"] == null ? null : json["tiempo"].toDouble(),
        area: json["area"] == null ? null : json["area"],
        sesionId: json["sesionId"] == null ? null : json["sesionId"],
    );

    Map<String, dynamic> toJson() => {
        "preguntas": preguntas == null ? null : preguntas,
        "aciertos": aciertos == null ? null : aciertos,
        "tiempo": tiempo == null ? null : tiempo,
        "area": area == null ? null : area,
        "sesionId": sesionId == null ? null : sesionId,
    };
}