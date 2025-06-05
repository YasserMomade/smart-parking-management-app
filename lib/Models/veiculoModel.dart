class VeiculoModel{

  final String id;
  final String marca;
  final String matricula;
  final String descricao;
  final String proprietario;

  VeiculoModel({

    required this.id,
    required this.marca,
    required this.matricula,
    required this.descricao,
    required this.proprietario,

});


  VeiculoModel.fromMap(Map<String, dynamic> map):

    id = map["id"],
    marca = map["marca"],
  matricula = map["matricula"],
  descricao = map["descricao"],
  proprietario = map["proprietario"];



  Map<String,dynamic> toMap(){
    return {
      "id": id,
      "marca": marca,
      "matricula": matricula,
      "descricao": descricao,
      "proprietario": proprietario
    };
  }

}