import 'package:flutter/material.dart';
import '../core/auth_controller.dart'; // Asegúrate de importar tu AuthController

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accedes al singleton de AuthController
    final auth = AuthController.instance;

    // Si no está logueado, lo mandas al login
    if (!auth.isLoggedIn) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/login');
      });

      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final usuario = auth.user!;
    final nombreCompleto = '${usuario.nombre} ${usuario.apellido}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Garden'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Al hacer logout, limpias el usuario y vas al login
              auth.user = null;
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bienvenida con el nombre del usuario
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.deepPurple.shade400,
                  child: Text(
                    usuario.nombre[0]
                        .toUpperCase(), // Primera letra en mayúscula
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenido,',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    Text(
                      nombreCompleto,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Línea de botones para navegar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _MenuButton(
                  icon: Icons.agriculture,
                  label: 'Tipos de Cultivos',
                  onPressed: () {
                    Navigator.pushNamed(context, '/tipos_cultivos');
                  },
                ),
                _MenuButton(
                  icon: Icons.water_drop,
                  label: 'Riego',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ir a módulo de riego')),
                    );
                  },
                ),
                _MenuButton(
                  icon: Icons.analytics,
                  label: 'Estadísticas',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ir a estadísticas')),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Contenido principal (placeholder)
            const Expanded(
              child: Center(
                child: Text(
                  'Aquí va el contenido principal',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple.shade400,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
