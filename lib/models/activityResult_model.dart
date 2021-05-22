class ActivityResult {
    ActivityResult({
         this.resultado,
         this.tiempo,
         this.area,
         this.indice,
         this.sesionId
    });

    String? sesionId;
    int? indice;
    bool? resultado;
    double? tiempo;
    String? area;

    factory ActivityResult.fromJson(Map<String, dynamic> json) => ActivityResult(
        resultado: json["resultado"] == null ? null : json["resultado"],
        tiempo: json["tiempo"] == null ? null : json["tiempo"].toDouble(),
        area: json["area"] == null ? null : json["area"],
        sesionId: json["sesionId"] == null ? null : json["sesionId"],
        indice: json["indice"] == null ? null : json["indice"].toInt(),
    );

    Map toJson() => {
        "resultado": resultado == null ? null : resultado,
        "tiempo": tiempo == null ? null : tiempo,
        "area": area == null ? null : area,
        "indice": indice == null ? null : indice,
        "sesionId":sesionId == null ? null :sesionId
    };
}