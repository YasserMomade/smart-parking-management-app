import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'EventosCategoriaView.dart';

class MenuEventoScreen extends StatelessWidget {
  const MenuEventoScreen({super.key});

  final List<Map<String, dynamic>> categorias = const [
    {"icon": Icons.shopping_cart, "label": "Supermercado"},
    {"icon": Icons.speaker, "label": "Espectaculo"},
    {"icon": Icons.local_parking, "label": "Parque"},
    {"icon": Icons.flight, "label": "Aeroporto"},
    {"icon": Icons.stadium, "label": "Espectaculo"},
    {"icon": Icons.add_circle, "label": "Mais"},
  ];

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
                  "Selecionar Evento",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.celebration_outlined),
              ],
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: categorias.map((cat) {

                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder:(_)=> TelaEventos(categoria: cat["label"],) ));
                  },

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(cat["icon"], size: 32),
                      const SizedBox(height: 8),
                      Text(cat["label"]),
                    ],
                  ),
                ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              "NB:Selecione o evento que pretendes agendar uma vaga",
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                child: const Text("Adicionar",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
