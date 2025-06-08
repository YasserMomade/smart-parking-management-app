import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/ReclamacaoModel.dart';

class ReclamacaoController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> adicionarReclamacao({
    required String titulo,
    required String descricao,
    required DateTime dataOcorrencia,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado.');
    }

    final reclamacao = ReclamacaoModel(
      id: '', // Firestore vai gerar
      titulo: titulo,
      descricao: descricao,
      dataOcorrencia: dataOcorrencia,
      userId: user.uid,
    );

    await _firestore.collection('reclamacoes').add(reclamacao.toMap());
  }

  Future<List<ReclamacaoModel>> listarReclamacoesDoUsuario() async {
    final user = _auth.currentUser;

    if (user == null) return [];

    final snapshot = await _firestore
        .collection('reclamacoes')
        .where('userId', isEqualTo: user.uid)
        .get();

    return snapshot.docs
        .map((doc) => ReclamacaoModel.fromMap(doc.data(), doc.id))
        .toList();
  }
  Future<List<ReclamacaoModel>> getTodasReclamacoes() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('reclamacoes').get();

      return snapshot.docs.map((doc) {
        return ReclamacaoModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print("Erro ao buscar reclamações: $e");
      return [];
    }
  }
}
