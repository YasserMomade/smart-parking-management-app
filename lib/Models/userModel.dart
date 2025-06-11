

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

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      numero: map['numero'] ?? '',
      senha: '',
    );
  }

  @override
  String toString() {
    return 'UserModel(nome: $nome, email: $email, senha: $senha, numero: $numero)';
  }

}