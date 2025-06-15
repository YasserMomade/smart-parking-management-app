import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marcacaovagas/Models/ReservaModel.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ReservaController {
  Future<void> realizarReserva({required ReservaModel reserva}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Reservas1')
          .doc(reserva.id)
          .set(reserva.toMap());
    } catch (e) {
      print(e);
    }
  }


  Future<List<ReservaModel>> getRecibos(String userId) async {
    try {

      CollectionReference reservasRef = _firestore.collection('Reservas1');

      QuerySnapshot querySnapshot = await reservasRef
          .where('userId', isEqualTo: userId)
          .get();

      List<ReservaModel> recibos = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        data['id'] = doc.id;

        return ReservaModel.fromMap(data);
      }).toList();

      return recibos;
    } catch (e) {
      print('Erro ao obter recibos: $e');
      return [];
    }
  }
}


