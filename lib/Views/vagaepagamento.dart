import 'package:flutter/material.dart';

void main() => runApp(const vagaepagamento());

class vagaepagamento extends StatelessWidget {
  const vagaepagamento({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VagaInfoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VagaInfoScreen extends StatelessWidget {
  const VagaInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text(
          'ParkWise',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Informacoes da Vaga',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Icon(Icons.edit_note, size: 24),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nº Vaga: 12'),
                  Text('Data: 17/05/2025'),
                  Text('Hora_Entrada: 8:25'),
                  Text('Hora_Saida: 17:25'),
                  Text('Evento: Espectaculo'),
                  Text('Valor: 450MT'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'selecione o Metodo de pagamento',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPaymentMethod(
                  iconPath: 'assets/emola.png', // substitua pelo caminho real
                  label: 'e-mola',
                  color: Colors.orange,
                ),
                _buildPaymentMethod(
                  iconPath: 'assets/mkesh.png',
                  label: 'MKesh',
                  color: Colors.green,
                ),
                _buildPaymentMethod(
                  iconPath: 'assets/mpesa.png',
                  label: 'M-Pesa',
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required String iconPath,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(iconPath, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
