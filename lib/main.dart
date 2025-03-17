import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartgardenv2/models/tipo_cultivos.dart';
import 'package:smartgardenv2/views/tipos_cultivos.dart';

import 'views/login.dart';
import 'views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Hive antes de correr la app
  await Hive.initFlutter();
  await Hive.openBox('authBox'); // Caja donde guardarás el estado de login

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider()..checkLoginStatus(),
      child: const MyApp(),
    ),
  );
}

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkLoginStatus() async {
    final box = Hive.box('authBox');
    _isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    notifyListeners();
  }

  void login() async {
    final box = Hive.box('authBox');
    await box.put('isLoggedIn', true);
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() async {
    final box = Hive.box('authBox');
    await box.put('isLoggedIn', false);
    _isLoggedIn = false;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Garden',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (auth.isLoggedIn) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/tipos_cultivos': (context) => const TipoCultivosScreen(),
      },
    );
  }
}
