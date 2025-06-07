import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Models/evento_model.dart';
import '../evento_service.dart';

class TelaEventos extends StatelessWidget {
  final String categoria;
  const TelaEventos({super.key,
    required this.categoria});

  Future<List<EventoModel>> _carregarEventos() {

    return EventoService().buscarEventosPorCategoria(categoria);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
        title: Center(

          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },


          child: Text(
            "ParkWise",
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Lista dos Eventos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<EventoModel>>(
                future: _carregarEventos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.black,));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Sem eventos disponíveis."));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      final evento = snapshot.data![index];
                      return EventoCard(evento: evento);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventoCard extends StatelessWidget {
  final EventoModel evento;

  const EventoCard({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          evento.titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            "${evento.data}\n${evento.horaInicio} até ${evento.horaFim}\nVagas disponíveis: ${evento.vagas}"),
        trailing: const Icon(Icons.more_vert),
        onTap: () {
          // Leva para a tela de marcação de vaga
          Navigator.pushNamed(context, '/marcar_vaga', arguments: evento);
        },
      ),
    );
  }
}
