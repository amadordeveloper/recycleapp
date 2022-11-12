class PuntoLimpio {
  int id;
  String nombre;
  String descripcion;
  double latitud;
  double longitud;

  PuntoLimpio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.latitud,
    required this.longitud
  });

  factory PuntoLimpio.fromJson(Map<String, dynamic> json) => PuntoLimpio(
    id: json["id"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    latitud: json["latitud"],
    longitud: json["longitud"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "descripcion": descripcion,
    "latitud": latitud,
    "longitud": longitud
  };

}
