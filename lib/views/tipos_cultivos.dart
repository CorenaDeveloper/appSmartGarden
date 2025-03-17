import 'package:flutter/material.dart';
import '../services/tipo_cultivo_services.dart'; // Asegúrate de tener la ruta correcta
import '../models/tipo_cultivos.dart';

class TipoCultivosScreen extends StatefulWidget {
  const TipoCultivosScreen({super.key});

  @override
  State<TipoCultivosScreen> createState() => _TipoCultivosScreenState();
}

class _TipoCultivosScreenState extends State<TipoCultivosScreen> {
  final CultivoApi cultivoApi = CultivoApi();

  late Future<List<TipoCultivo>> _futureCultivos;

  @override
  void initState() {
    super.initState();
    _futureCultivos = cultivoApi.getTipoCultivos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tipos de Cultivos')),
      body: FutureBuilder<List<TipoCultivo>>(
        future: _futureCultivos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 10),
                  Text(
                    'Error al cargar los cultivos:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureCultivos = cultivoApi.getTipoCultivos();
                      });
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final cultivos = snapshot.data ?? [];

          if (cultivos.isEmpty) {
            return const Center(child: Text('No hay cultivos disponibles.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cultivos.length,
            itemBuilder: (context, index) {
              final cultivo = cultivos[index];
              return _buildCultivoCard(cultivo);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí puedes poner la lógica para agregar un nuevo cultivo
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Agregar nuevo cultivo')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCultivoCard(TipoCultivo cultivo) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple.shade400,
            child: Text(
              cultivo.nombre.isNotEmpty ? cultivo.nombre[0].toUpperCase() : '?',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          title: Text(
            cultivo.nombre,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            cultivo.descripcion,
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                // Lógica para editar
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Editar cultivo')));
              } else if (value == 'delete') {
                _confirmDelete(cultivo);
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Editar')),
                  const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(TipoCultivo cultivo) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Eliminar cultivo'),
            content: Text('¿Estás seguro de eliminar "${cultivo.nombre}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    await cultivoApi.deleteTipoCultivo(cultivo.idTipoCultivo);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cultivo eliminado')),
                    );
                    setState(() {
                      _futureCultivos = cultivoApi.getTipoCultivos();
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al eliminar: $e')),
                    );
                  }
                },
                child: const Text('Eliminar'),
              ),
            ],
          ),
    );
  }
}
