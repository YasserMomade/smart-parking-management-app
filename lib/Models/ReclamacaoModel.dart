class ReclamacaoModel {
  final String id;
  final String titulo;
  final String descricao;
  final DateTime dataOcorrencia;
  final String userId;

  ReclamacaoModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.dataOcorrencia,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'dataOcorrencia': dataOcorrencia.toIso8601String(),
      'userId': userId,
    };
  }

  factory ReclamacaoModel.fromMap(Map<String, dynamic> map, String id) {
    return ReclamacaoModel(
      id: id,
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      dataOcorrencia: DateTime.parse(map['dataOcorrencia']),
      userId: map['userId'] ?? '',
    );
  }
}
