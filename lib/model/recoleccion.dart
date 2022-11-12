class Recoleccion {
  int id;
  String nombre;
  String tipo;
  String peso;
  String dimensiones;
  String direccion;
  String ciudad;
  String telefono;
  String correo;

  Recoleccion({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.peso,
    required this.dimensiones,
    required this.direccion,
    required this.ciudad,
    required this.telefono,
    required this.correo,
  });

  factory Recoleccion.fromJson(Map<String, dynamic> json) {
    return Recoleccion(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      peso: json['peso'],
      dimensiones: json['dimensiones'],
      direccion: json['direccion'],
      ciudad: json['ciudad'],
      telefono: json['telefono'],
      correo: json['correo'],
    );
  }

  toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo': tipo,
      'peso': peso,
      'dimensiones': dimensiones,
      'direccion': direccion,
      'ciudad': ciudad,
      'telefono': telefono,
      'correo': correo,
    };
  }

}
