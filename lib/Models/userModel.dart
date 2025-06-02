

class UserModel{

  final String nome;
  final String email;
  final String senha;
  final int numero;

  UserModel({
    required this.nome,
    required this.email,
    required this.senha,
    required this.numero,
  });


  Map<String, dynamic> toMap(){
    return {
      'nome':nome,
      'email':email,
      'numero':numero,
    };
  }

  @override
  String toString() {
    return 'UserModel(nome: $nome, email: $email, senha: $senha, numero: $numero)';
  }

}