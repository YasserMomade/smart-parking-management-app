import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/evento_model.dart';

class EventoController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _eventosRef = FirebaseFirestore.instance.collection('eventos');

  // ✅ CORRETO: Recebe um EventoModel
  Future<void> adicionarEvento(EventoModel evento) async {
    try {
      await _eventosRef.add(evento.toMap());
    } catch (e) {
      print('Erro ao adicionar evento: $e');
      rethrow;
    }
  }

  Future<List<EventoModel>> buscarEventos() async {
    try {
      final snapshot = await _eventosRef.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return EventoModel.fromMap(data, doc.id);
      }).toList();
    } catch (e) {
      print('Erro ao buscar eventos: $e');
      rethrow;
    }
  }

  Future<void> atualizarEvento(String id, EventoModel evento) async {
    try {
      await _eventosRef.doc(id).update(evento.toMap());
    } catch (e) {
      print('Erro ao atualizar evento: $e');
      rethrow;
    }
  }

  Future<void> deletarEvento(String id) async {
    try {
      await _eventosRef.doc(id).delete();
    } catch (e) {
      print('Erro ao deletar evento: $e');
      rethrow;
    }
  }
}
