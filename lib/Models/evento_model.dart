class EventoModel {
  final String? id;
  final String titulo;
  final DateTime data;
  final String horaInicio;
  final String horaFim;
  final double valor;
  final String tipo;
  final int vagas;
  final String local;


  EventoModel({
    this.id,
    required this.titulo,
    required this.data,
    required this.horaInicio,
    required this.horaFim,
    required this.valor,
    required this.tipo,
    required this.vagas,
    required this.local,

  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'data': data.toIso8601String(),
      'horaInicio': horaInicio,
      'horaFim': horaFim,
      'valor': valor,
      'tipo': tipo,
      'vags': vagas,
      'local':local

    };
  }

  factory EventoModel.fromMap(Map<String, dynamic> map, String id) {
    return EventoModel(
        id: id,
        titulo: map['titulo'] ?? '',
        data: DateTime.parse(map['data']),
        horaInicio: map['horaInicio'] ?? '',
        horaFim: map['horaFim'] ?? '',
        valor: (map['valor'] as num).toDouble(),
        tipo: map['tipo'] ?? '',
        vagas: map['vags']?? 0,
        local: map['local']?? ''
    );
  }
}
