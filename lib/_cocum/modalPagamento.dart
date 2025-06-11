import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marcacaovagas/Controllers/ReservaController.dart';
import '../Models/ReservaModel.dart';
import '../Views/menu.dart';


class ModalPagamento extends StatefulWidget {
  final double valor;
  final String entidade;
  final String referencia;
  final String metodo;
  final String veiculoMatricula;
  final String eventoNome;
  final String eventoTipo;
  final String metodoPagamento;
  final String eventoHoraInicio;
  final String eventoHoraFim;
  final DateTime dataHora;
  final String userId;
  final int vaga;

  const ModalPagamento({
    super.key,
    required this.valor,
    required this.entidade,
    required this.referencia,
    required this.metodo,
    required this.veiculoMatricula,
    required this.eventoNome,
    required this.eventoTipo,
    required this.metodoPagamento,
    required this.eventoHoraInicio,
    required this.eventoHoraFim,
    required this.dataHora,
    required this.userId,
    required this.vaga,
  });

  @override
  State<ModalPagamento> createState() => _ModalPagamentoState();
}

class _ModalPagamentoState extends State<ModalPagamento> {
  final TextEditingController _pinController = TextEditingController();
  bool _carregando = false;

  void _mostrarSnackBar(String mensagem, {bool sucesso = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: sucesso ? Colors.green : Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _confirmarPagamento() async {
    final pin = _pinController.text;
    if (pin.isEmpty) {
      _mostrarSnackBar('Digite seu PIN', sucesso: false);
      return;
    }
    setState(() => _carregando = true);

    final reserva = ReservaModel(
      metodoPagamento: widget.metodoPagamento,
      valor: widget.valor,
      id: widget.referencia,
      dataHora: DateTime.now(),
      userId: widget.userId,
      veiculoMatricula: widget.veiculoMatricula,
      eventoNome: widget.eventoNome,
      eventoTipo: widget.eventoTipo,
      eventoHoraInicio: widget.eventoHoraInicio,
      eventoHoraFim: widget.eventoHoraFim,
      vaga: widget.vaga,
    );

    try {
      await ReservaController().realizarReserva(reserva: reserva);
      if (context.mounted) {
        _mostrarSnackBar('Vaga Marcada com sucesso!, Veja os recibos', sucesso: true);


        await Future.delayed(Duration(seconds: 1));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                telaMenu(user: FirebaseAuth.instance.currentUser!),
          ),
        );
      }
    } catch (e) {
      _mostrarSnackBar('Erro ao realizar pagamento', sucesso: false);
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text('Confirmar Pagamento', style: TextStyle(color: Colors.white)),
      content: _carregando
          ? Center(child: CircularProgressIndicator())
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Vais pagar ${widget.valor.toStringAsFixed(2)}MT na Entidade ${widget.entidade}\nreferente à transação ${widget.referencia}.',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _pinController,
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white10,
              hintText: 'Digite o teu PIN',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      actions: _carregando
          ? []
          : [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: _confirmarPagamento,
          child: Text('Enviar', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}