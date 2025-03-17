import '../core/dio_cliente.dart';
import '../models/tipo_cultivos.dart';
import 'package:dio/dio.dart';

class CultivoApi {
  final Dio _dio = DioClient().dio;

  /// GET - Obtener todos los cultivos
  Future<List<TipoCultivo>> getTipoCultivos() async {
    try {
      final response = await _dio.get(
        'DB_SmartGarden_TipoCultivo/Tipo_Cultivo',
      );

      // Si el backend devuelve una lista
      final List<dynamic> data = response.data;

      // Convertir cada item a un objeto TipoCultivo
      return data.map((e) => TipoCultivo.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error al obtener los cultivos: $e');
    }
  }

  /// POST - Crear un nuevo cultivo
  Future<void> createTipoCultivo(TipoCultivo cultivo) async {
    try {
      await _dio.post(
        'DB_SmartGarden_TipoCultivo/Tipo_Cultivo',
        data: cultivo.toJson(),
      );
    } catch (e) {
      throw Exception('Error al crear el cultivo: $e');
    }
  }

  /// PUT - Actualizar un cultivo existente
  Future<void> updateTipoCultivo(TipoCultivo cultivo) async {
    try {
      await _dio.put(
        'DB_SmartGarden_TipoCultivo/Tipo_Cultivo/${cultivo.idTipoCultivo}',
        data: cultivo.toJson(),
      );
    } catch (e) {
      throw Exception('Error al actualizar el cultivo: $e');
    }
  }

  /// DELETE - Eliminar un cultivo por ID
  Future<void> deleteTipoCultivo(int idTipoCultivo) async {
    try {
      await _dio.delete(
        'DB_SmartGarden_TipoCultivo/Tipo_Cultivo/$idTipoCultivo',
      );
    } catch (e) {
      throw Exception('Error al eliminar el cultivo: $e');
    }
  }
}
