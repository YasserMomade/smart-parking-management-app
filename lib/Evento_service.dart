import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/evento_model.dart';

class EventoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<EventoModel>> buscarEventosPorCategoria(String categoria) async {
    final snapshot = await _firestore
        .collection('eventos')
        .where('tipo', isEqualTo: categoria) // usa o campo correto
        .get();

    return snapshot.docs
        .map((doc) => EventoModel.fromMap(doc.data(), doc.id)) // funciona com o model certo
        .toList();
  }
}

