import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Controllers/UserController.dart';
import 'menu.dart';


class TelaListarVeiculos extends StatefulWidget {
  const TelaListarVeiculos({super.key});

  @override
  State<TelaListarVeiculos> createState() => _TelaListarVeiculosState();
}

class _TelaListarVeiculosState extends State<TelaListarVeiculos> {

// Pegando utilizador
 String? userId;
 String? userEmail;

 @override
 void initState(){
   super.initState();
   _loadUser();
 }

 void  _loadUser(){
   User? user = FirebaseAuth.instance.currentUser;

   if(user != null){
     userId = user.uid;
     userEmail = user.email;
   }

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      drawer:  Drawer(

        child: ListView(
          children: [

            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF0052D4),
                ),

                currentAccountPicture: Container(
                  width: 200,
                  height: 290,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),


                accountEmail: Text(userEmail!), accountName: null,


            ),

            ListTile(
              title: Text("Menu"), leading: Icon(Icons.home_rounded),
              onTap: (){

              },
            ),

            Divider(),

            ListTile(
              title: Text("Sair"), leading: Icon(Icons.logout),
              onTap: (){
                UserController().logOut();
              },
            ),



          ],

        ),


      ),


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
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (_, index) => const VeiculoCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VeiculoCard extends StatelessWidget {
  const VeiculoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Veículo Card Tapped');
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
          title: const Text(
            "Mark X",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text("Matricula: AF1-DSF"),
          trailing: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}