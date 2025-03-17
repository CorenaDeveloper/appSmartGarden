class TipoCultivo {
  final int idTipoCultivo;
  final String nombre;
  final String descripcion;

  TipoCultivo({
    required this.idTipoCultivo,
    required this.nombre,
    required this.descripcion,
  });

  // Factory para mapear desde JSON
  factory TipoCultivo.fromJson(Map<String, dynamic> json) {
    return TipoCultivo(
      idTipoCultivo: json['idTipoCultivo'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }

  // Método para enviar en el body de PUT o POST
  Map<String, dynamic> toJson() {
    return {
      'idTipoCultivo': idTipoCultivo,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
