import '../models/usuario.dart';

class AuthController {
  // Singleton básico
  static final AuthController _instance = AuthController._internal();
  factory AuthController() => _instance;
  AuthController._internal();

  static AuthController get instance =>
      _instance; // ✅ Esto te permite usar AuthController.instance

  Usuario? user;

  bool get isLoggedIn => user != null;
}
