import 'package:flutter/material.dart';

void main() => runApp(const ParkWiseApp());

class ParkWiseApp extends StatelessWidget {
  const ParkWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PerfilScreen(),
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
              icon: Icons.person_outline,
              label: 'Editar Perfil',
            ),
            const SizedBox(height: 12),
            _buildOptionTile(
              icon: Icons.chat_bubble_outline,
              label: 'Notificacoes',
            ),
            const SizedBox(height: 12),
            _buildOptionTile(
              icon: Icons.lock_outline,
              label: 'Alterar Senha',
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
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

  Widget _buildOptionTile({required IconData icon, required String label}) {
    return Row(
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
    );
  }
}
