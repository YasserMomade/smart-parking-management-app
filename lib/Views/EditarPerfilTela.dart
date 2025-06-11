import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Controllers/userController.dart';
import '../Models/userModel.dart';

class EditarPerfilTela extends StatefulWidget {
  const EditarPerfilTela({super.key});

  @override
  State<EditarPerfilTela> createState() => _EditarPerfilTelaState();
}

class _EditarPerfilTelaState extends State<EditarPerfilTela> {
  final _userController = UserController();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  String? userId;
  bool carregando = false;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      await _carregarDadosUsuario();
    }
  }

  Future<void> _carregarDadosUsuario() async {
    if (userId == null) return;

    setState(() {
      carregando = true;
    });

    final userModel = await _userController.getUserData(userId!);

    if (userModel != null) {
      setState(() {
        _nomeController.text = userModel.nome;
        _emailController.text = userModel.email;
        _numeroController.text = userModel.numero.toString();
      });
    }

    setState(() {
      carregando = false;
    });
  }

  Future<void> _salvarAlteracoes() async {
    if (userId == null) return;

    final userAtualizado = UserModel(
      nome: _nomeController.text,
      email: _emailController.text,
      numero: _numeroController.hashCode,
      senha: '',
    );

    await _userController.updateUser(userAtualizado, userId!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados atualizados com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text(
          'ParkWise',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Editar Perfil',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              _buildInputField('Nome', _nomeController),
              const SizedBox(height: 20),
              _buildInputField('Email', _emailController),
              const SizedBox(height: 20),
              _buildInputField('Número', _numeroController,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _salvarAlteracoes,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Alterar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String labelText, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: 'Altere o seu $labelText',
          ),
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
