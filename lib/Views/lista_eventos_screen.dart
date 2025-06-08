import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListaEventosScreen extends StatelessWidget {
  const ListaEventosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(), // futuro menu lateral
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  "Lista dos Eventos",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.celebration_outlined),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (_, index) => EventoCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventoCard extends StatelessWidget {
  const EventoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navega para a tela de menu de eventos
        Navigator.pushNamed(context, '/menu');
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: const Text(
            "Picasso Eventos",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text("12/05/2025\n7:10 ate 17:30"),
          trailing: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
