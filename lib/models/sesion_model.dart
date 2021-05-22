
class Sesion {
    Sesion({
        this.student,
        this.tipo,
       this.fecha,
       this.estado,
       this.id
    });

    int? tipo;
    DateTime? fecha;
    String? student;
    bool? estado;
    String? id;
    factory Sesion.fromJson(Map<String, dynamic> json) => Sesion(
        student: json["student"] == null ? null : json["student"],
        tipo: json["tipo"] == null ? null : json["tipo"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        estado: json["estado"] == null ? null : json["estado"],
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "student": student == null ? null : student,
        "tipo": tipo == null ? null : tipo,
        "fecha": fecha == null ? null : fecha!.toIso8601String(),
        "estado": estado == null ? null : estado,
        "id":id==null?null:id
        };
}
