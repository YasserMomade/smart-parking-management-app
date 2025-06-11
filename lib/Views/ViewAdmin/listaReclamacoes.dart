import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Controllers/ReclamacaoController.dart';
import '../../Models/ReclamacaoModel.dart';
import 'package:marcacaovagas/Controllers/UserController.dart';

class TelaListarReclamacoesAdmin extends StatefulWidget {
  const TelaListarReclamacoesAdmin({super.key});

  @override
  State<TelaListarReclamacoesAdmin> createState() => _TelaListarReclamacoesAdminState();
}

class _TelaListarReclamacoesAdminState extends State<TelaListarReclamacoesAdmin> {
  bool carregando = false;
  String? userEmail;
  List<ReclamacaoModel> listaReclamacoes = [];

  @override
  void initState() {
    super.initState();
    _getUser();
    _listarReclamacoes();
  }

  void _getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email;
      });
    }
  }

  Future<void> _listarReclamacoes() async {
    setState(() {
      carregando = true;
    });

    final reclamacaoController = ReclamacaoController();
    final lista = await reclamacaoController.getTodasReclamacoes();

    setState(() {
      listaReclamacoes = lista;
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF0052D4)),
              currentAccountPicture: Container(
                width: 200,
                height: 290,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              accountEmail: Text(userEmail ?? ''), accountName: null,
            ),
            ListTile(
              title: const Text("Menu"), leading: const Icon(Icons.home_rounded),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: const Text("Sair"), leading: const Icon(Icons.logout),
              onTap: () {
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
              children: const [
                Icon(Icons.feedback_outlined),
                SizedBox(width: 8),
                Text(
                  "Lista de Reclamações",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: carregando
                  ? const Center(child: CircularProgressIndicator(color: Colors.blueAccent))
                  : listaReclamacoes.isEmpty
                  ? const Center(child: Text("Nenhuma reclamação registrada."))
                  : ListView.builder(
                itemCount: listaReclamacoes.length,
                itemBuilder: (_, i) {
                  final reclamacao = listaReclamacoes[i];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: const Icon(Icons.report_problem, color: Colors.red, size: 30),
                      title: Text(
                        reclamacao.titulo,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Data: ${reclamacao.dataOcorrencia}\nDescrição: ${reclamacao.descricao}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
