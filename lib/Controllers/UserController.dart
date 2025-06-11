import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../Models/userModel.dart';

class UserController {

  //Instancias de firebaseAuth e Firestote
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> cadastrarUser(UserModel user) async {
    try {
      //Criar conta no firebaseAuth com email e senha
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(
          email: user.email, password: user.senha);

          await credential.user!.updateDisplayName(user.nome);

      //Salvar dados adicionais no firestore como nome e numero

      final firebaseUser = credential.user;
      if (firebaseUser != null) {
        try {
          print("Salvando dados no Firestore...");
          await _firestore.collection('utilizador').doc(firebaseUser.uid).set(
              user.toMap());
          print("Salvo com sucesso");
        } catch (e) {
          return "Erro ao salvar no foresStore: $e";
        }
      }


      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<UserModel?> getUserData(String userId) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('utilizador').doc(userId).get();
        if (doc.exists) {
          final data = doc.data()!;
          return UserModel.fromMap({...data, 'uid': userId});
        }
      }
      return null;
    } catch (e) {
      print("Erro ao buscar dados do usuario: $e");
      return null;
    }
  }


  Future<String?> logarUser({required UserModel user}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.senha);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }



  Future<void> updateUser(UserModel user, String userId) async {
    try {
      await _firestore.collection('utilizador').doc(userId).update(user.toMap());
    } catch (e) {
      print("Erro ao atualizar dados: $e");
    }
  }

  Future<void> logOut() async{
    _firebaseAuth.signOut();
  }







}