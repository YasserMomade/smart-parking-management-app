
import 'package:flutter/material.dart';

void main() => runApp(const HoraChegadaApp());

class HoraChegadaApp extends StatelessWidget {
  const HoraChegadaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HoraChegada(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HoraChegada extends StatefulWidget {
  const HoraChegada({super.key});

  @override
  State<HoraChegada> createState() => _MarkSlotScreenState();
}

class _MarkSlotScreenState extends State<HoraChegada> {
  TimeOfDay? _horaSelecionada;

  Future<void> _selecionarHora() async {
    final hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (hora != null) {
      setState(() {
        _horaSelecionada = hora;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String horaFormatada = _horaSelecionada != null
        ? _horaSelecionada!.format(context)
        : 'Nenhuma hora selecionada';

    return Scaffold(
      appBar: AppBar(
        title: const Text('ParkWise', style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selecionar Hora',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'O utilizador só pode selecionar a hora de chegada dentro do intervalo de tempo de início e fim do evento.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _selecionarHora,
              icon: const Icon(Icons.access_time, color: Colors.white),
              label: const Text(
                'Escolher Hora',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_horaSelecionada != null)
              Column(
                children: [
                  const Text(
                    'Hora Selecionada:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  Icon(
                    Icons.access_time_filled,
                    size: 100,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    horaFormatada,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: _horaSelecionada != null ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Confirmar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
