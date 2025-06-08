import 'package:ParkWise/Models/evento_model.dart';
import 'package:ParkWise/Views/vagaepagamento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Controllers/UserController.dart';
import '../Controllers/veiculoController.dart';
import '../Models/veiculoModel.dart';
import 'menu.dart';


class SelecionarVeiculos extends StatefulWidget {
  SelecionarVeiculos({super.key,required this.eventoModel});

  final EventoModel eventoModel;

  @override
  State<SelecionarVeiculos> createState() => _SelecionarVeiculosState();
}

class _SelecionarVeiculosState extends State<SelecionarVeiculos> {

  bool carregando = false;

// Pegando utilizador
  String? userId;
  String? userEmail;


  @override
  void initState(){
    super.initState();
    _getUser();
    _listarVeiculos();
  }

  void  _getUser() async{
    User? user = FirebaseAuth.instance.currentUser;

    if(user != null){
      setState(() {
        userId = user.uid;
        userEmail = user.email;
      });

      await _listarVeiculos();

    }
  }
  Future<void> _listarVeiculos() async{

    setState(() {
      carregando = true;
    });

    final veiculoController = VeiculoController();
    final lista = await veiculoController.getveiculos(userId!);

    setState(() {
      listaVeiculos = lista;
      carregando = false;
    });

  }


  List<VeiculoModel> listaVeiculos = [];




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
              title: Text(widget.eventoModel.tipo), leading: Icon(Icons.home_rounded),
              onTap: (){

                Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(
                      builder: (_) =>
                          telaMenu(user: FirebaseAuth.instance.currentUser!)),
                      (Route<dynamic> route) => false,);

              },
            ),

            Divider(),

            ListTile(
              title: Text("Sair"), leading: Icon(Icons.logout),
              onTap: (){
                UserController().logOut();
                Navigator.pop(context);
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
                    Navigator.pop(context);
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

            Expanded(child: carregando ?
            const Center(child: CircularProgressIndicator(color: Colors.blueAccent),)
                :listaVeiculos.isEmpty ? const Center(
              child: Text("Voce nao tem veiculos cadastrados.") ,):
            ListView.builder(
                itemCount: listaVeiculos.length,
                itemBuilder: (_, i){
                  final veiculo = listaVeiculos[i];
                  return VeiculoCard(
                    veiculo: veiculo,
                    onUpdate: _listarVeiculos,
                    eventoModel: widget.eventoModel,


                  );
                }))

          ],
        ),
      ),
    );
  }
}

class VeiculoCard extends StatelessWidget {
  final VeiculoModel veiculo;
  final VoidCallback onUpdate;
  final EventoModel eventoModel;

  const VeiculoCard({super.key,
    required this.veiculo,
    required this.onUpdate,
    required this.eventoModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            );
          },
        );

        final firestore = FirebaseFirestore.instance;
        final eventoRef = firestore.collection('eventos').doc(eventoModel.id);

        try {
          await firestore.runTransaction((transaction) async {
            final snapshot = await transaction.get(eventoRef);

            if (!snapshot.exists) {
              Navigator.pop(context); // fecha o loader
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Evento não encontrado')),
              );
              return;
            }

            int vagas = snapshot.get('vags') ?? 0;

            if (vagas <= 0) {
              Navigator.pop(context); // fecha o loader
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nenhuma vaga disponível para este evento')),
              );
              return;
            }

            int vagaSelecionada = vagas;


            transaction.update(eventoRef, {'vags': vagas - 1});

            Navigator.pop(context);


            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => vagaepagamento(
                  veiculoModel: veiculo,
                  eventoModel: eventoModel, numeroVaga: vagaSelecionada,
                  
                ),
              ),
            );
          });
        } catch (e) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao reservar vaga: $e')),
          );
        }
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
            veiculo.marca,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Matricula: ${veiculo.matricula}"),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'remover') {
                _confRemover(context, veiculo);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'remover',
                child: Text("Remover veículo"),
              ),
            ],
          ),
        ),
      ),
    );


  }



  void  _confRemover(BuildContext context, VeiculoModel veiculo){

    showDialog(context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar"),
        content: Text("Deseja eliminar a ${veiculo.marca}"),

        actions: [
          TextButton(onPressed: () => Navigator.pop(context),
              child: Text("Cancelar")),

          ElevatedButton(onPressed: () async{
            Navigator.pop(context);



            await VeiculoController().delVeiculo(veiculo.id);

            onUpdate();

          },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Eliminar"),
          )
        ],

      ),);
  }



}