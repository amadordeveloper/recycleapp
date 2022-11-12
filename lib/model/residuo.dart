// generate class Residuo with properties Nombre, Aprovechamiento, Destino, Impacto, Claves, Descripcion
class Residuo {
  final int id;
  final String nombre;
  final String aprovechamiento;
  final String destino;
  final String impacto;
  final String descripcion;

  const Residuo({
    required this.id,
    required this.nombre,
    required this.aprovechamiento,
    required this.destino,
    required this.impacto,
    required this.descripcion
  });

  factory Residuo.fromJson(Map<String, dynamic> json) {
    return Residuo(
      id: json['id'],
      nombre: json['nombre'],
      aprovechamiento: json['aprovechamiento'],
      destino: json['destino'],
      impacto: json['impacto'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'aprovechamiento': aprovechamiento,
      'destino': destino,
      'impacto': impacto,
      'descripcion': descripcion,
    };
  }
}
