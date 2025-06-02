

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marcacaovagas/Models/userModel.dart';

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


  Future<String?> logarUser({required UserModel user}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.senha);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logOut() async{
    _firebaseAuth.signOut();
  }

}