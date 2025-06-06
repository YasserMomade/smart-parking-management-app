


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marcacaovagas/Models/veiculoModel.dart';

class VeiculoController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addVeiculo(VeiculoModel veiculo)async {

    try {
      return await _firestore.collection("veiculos")
          .doc(veiculo.id)
          .set(veiculo.toMap());

      print('veiculo adicionado com sucesso');

    }catch(e){
      print("erro ao adicionar veicolo: $e");
    }
  }

  Future<List<VeiculoModel>> getveiculos(String userId) async {

    try {
      final snaphot = await _firestore.collection('veiculos')
          .where('proprietario', isEqualTo: userId).get();

      return snaphot.docs
          .map((doc) => VeiculoModel.fromMap(doc.data())).toList();

    }catch(e){
      print("Erro ao buscar veiculos: $e");
      return [];
    }
  }

  Future<void> delVeiculo(String id) async {
    await _firestore.collection('veiculos').doc(id).delete();
  }

}