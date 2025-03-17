class Usuario {
  final int idUsuario;
  final String nombre;
  final String apellido;
  final String email;
  final String usuario;
  final bool estado;
  final bool emailVerificado;

  Usuario({
    required this.idUsuario,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.usuario,
    required this.estado,
    required this.emailVerificado,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json['idUsuario'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      email: json['email'],
      usuario: json['usuario'],
      estado: json['estado'],
      emailVerificado: json['emailVerificado'],
    );
  }
}
