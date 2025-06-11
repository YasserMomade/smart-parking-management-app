import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Controllers/UserController.dart';
import 'EditarPerfilTela.dart';
import 'AlterarSenhaTela.dart';
import 'menu.dart';

void main() => runApp(const perfil());

class perfil extends StatelessWidget {
  const perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PerfilScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

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

      // Drawer adicionado aqui
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0052D4),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
              ),
              accountEmail: Text("albino@gmail.com"),
              accountName: null,
            ),
            ListTile(
              title: const Text("Menu"),
              leading: const Icon(Icons.home_rounded),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        telaMenu(user: FirebaseAuth.instance.currentUser!),
                  ),
                      (Route<dynamic> route) => false,
                );
              },
            ),
            ListTile(
              title: const Text("Perfil"),
              leading: const Icon(Icons.person_2_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const perfil(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text("Sair"),
              leading: const Icon(Icons.logout),
              onTap: () {
                UserController().logOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Perfil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 32),
            _buildOptionTile(
              context: context,
              icon: Icons.person_outline,
              label: 'Editar Perfil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditarPerfilTela()),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildOptionTile(
              context: context,
              icon: Icons.chat_bubble_outline,
              label: 'Notificações',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildOptionTile(
              context: context,
              icon: Icons.lock_outline,
              label: 'Alterar Senha',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Alterarsenhatela()),
                );
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
              child: const Text(
                'Sair',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
