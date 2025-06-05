import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marcacaovagas/Models/veiculoModel.dart';

import '../Controllers/UserController.dart';
import 'menu.dart';


class TelaListarVeiculos extends StatefulWidget {
  const TelaListarVeiculos({super.key});

  @override
  State<TelaListarVeiculos> createState() => _TelaListarVeiculosState();
}

class _TelaListarVeiculosState extends State<TelaListarVeiculos> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(


      


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
        title: const Center(
          child: Text(
            "ParkWise",
            style: TextStyle(
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
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // Navigate to 'telaMenu'
                    //Navigator.push(
                    //  context,
                     // MaterialPageRoute(
                       // builder: (context) => const telaMenu(),
                      //),
                    //);
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  "Lista de Veículos",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.directions_car_filled),
              ],
            ),

            const SizedBox(height: 16),

            

          ],
        ),
      ),
    );
  }
}

class VeiculoCard extends StatelessWidget {
  final VeiculoModel veiculo;

  const VeiculoCard({super.key,
    required this.veiculo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Veiculo clicad: ${veiculo.id}');
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: const Icon(
            Icons.directions_car_filled,
            color: Colors.orange,
            size: 30,
          ),

          title: Text(
            "mark x",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle:  Text("Matricula: 20222"),
          trailing: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
