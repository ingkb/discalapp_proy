
class Sesion {
    Sesion({
        this.student,
        this.tipo,
        this.fecha,
    });

    int tipo;
    DateTime fecha;
    String student;

    factory Sesion.fromJson(Map<String, dynamic> json) => Sesion(
        student: json["student"] == null ? null : json["student"],
        tipo: json["tipo"] == null ? null : json["tipo"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "student": student == null ? null : student,
        "tipo": tipo == null ? null : tipo,
        "fecha": fecha == null ? null : fecha.toIso8601String(),
        };
}
