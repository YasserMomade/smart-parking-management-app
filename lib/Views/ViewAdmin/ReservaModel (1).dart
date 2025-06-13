class ReservaModel {
  final String id;
  final String veiculoMatricula;
  final String eventoNome;
  final String eventoTipo;
  final String metodoPagamento;
  final double valor;
  final String eventoHoraInicio;
  final String eventoHoraFim;
  final DateTime dataHora;
  final String userId;
  final int vaga;

  ReservaModel({
    required this.vaga,
    required this.id,
    required this.veiculoMatricula,
    required this.eventoNome,
    required this.eventoTipo,
    required this.eventoHoraInicio,
    required this.eventoHoraFim,
    required this.metodoPagamento,
    required this.valor,
    required this.dataHora,
    required this.userId,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'vaga': vaga,
    'veiculoMatricula': veiculoMatricula,
    'eventoNome': eventoNome,
    'eventoTipo': eventoTipo,
    'eventoHoraInicio': eventoHoraInicio,
    'eventoHoraFim': eventoHoraFim,
    'metodoPagamento': metodoPagamento,
    'valor': valor,
    'dataHora': dataHora.toIso8601String(),
    'userId': userId,
  };

  factory ReservaModel.fromMap(Map<String, dynamic> map) => ReservaModel(
    veiculoMatricula: map['veiculoMatricula'],
    eventoNome: map['eventoNome'],
    eventoTipo: map['eventoTipo'],
    eventoHoraInicio: map['eventoHoraInicio'],
    eventoHoraFim: map['eventoHoraFim'],
    metodoPagamento: map['metodoPagamento'],
    valor: map['valor'],
    dataHora: DateTime.parse(map['dataHora']),
    userId: map['userId'],
    id: map['id'],
    vaga: map['vaga'],
  );
}
