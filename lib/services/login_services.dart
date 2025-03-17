import 'package:dio/dio.dart';
import '../models/usuario.dart';
import '../core/dio_cliente.dart'; // Importamos el cliente centralizado

class LoginService {
  final Dio _dio = DioClient().dio; // Usamos el Dio centralizado

  Future<Usuario?> login(String email, String pass) async {
    try {
      final response = await _dio.post(
        'DB_SmartGarden_Usuarios/Login', // ✅ Solo el endpoint (ya tienes el baseUrl en DioClient)
        data: {'email': email, 'contraseña': pass},
      );

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(response.data);

        if (user.estado && user.emailVerificado) {
          return user;
        }
      }

      return null;
    } catch (e) {
      print('Error en el login: $e');
      return null;
    }
  }
}
