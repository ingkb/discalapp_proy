class ActivityResult {
    ActivityResult({
         this.resultado,
         this.tiempo,
         this.area,
    });

     bool resultado;
    double tiempo;
    String area;

    factory ActivityResult.fromJson(Map<String, dynamic> json) => ActivityResult(
        resultado: json["resultado"] == null ? null : json["resultado"],
        tiempo: json["tiempo"] == null ? null : json["tiempo"].toDouble(),
        area: json["area"] == null ? null : json["area"],
    );

    Map<String, dynamic> toJson() => {
        "resultado": resultado == null ? null : resultado,
        "tiempo": tiempo == null ? null : tiempo,
        "area": area == null ? null : area,
    };
}