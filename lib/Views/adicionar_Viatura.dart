import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Controllers/veiculoController.dart';
import '../Models/veiculoModel.dart';

class AdicionarViatura extends StatefulWidget {
  const AdicionarViatura({super.key});

  @override
  State<AdicionarViatura> createState() => _estadoTelaAddViatura();
}

class _estadoTelaAddViatura extends State<AdicionarViatura> {

  String? userId;
  String? userEmail;

  @override
  void initState(){
    super.initState();
    _getUser();
  }

  void _getUser(){
    User? user = FirebaseAuth.instance.currentUser;

    if(user != null) {
      userId = user.uid;
      userEmail = user.email;
    }
  }

  bool carregando = false;
  VeiculoController _veiculoController = VeiculoController();

  final _formKey = GlobalKey<FormState>();
  final _marcaController = TextEditingController();
  final _matriculaController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  void dispose() {
    _marcaController.dispose();
    _matriculaController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    'ParkWise',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2196F3), // Azul do ParkWise
                    ),
                  ),
                  Icon(
                    Icons.notifications_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0), // Padding horizontal conforme a imagem de cadastro
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      //Tiltulo
                      Row(
                        children: [
                          Text(
                            'Adicionar Veículo',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.add_circle_outline, // Ícone de adição de veículo
                            size: 28,
                            color: Colors.black,
                          ),
                        ],
                      ),

                      const SizedBox(height: 60), // Espaçamento maior antes dos campos

                      // Campo Marca
                      _buildTextField(
                        controller: _marcaController,
                        labelText: 'Marca',
                        hintText: 'Por favor digite a marca do seu veículo', // Mantendo o hintText original
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20), // Espaçamento entre os campos, conforme o estilo da imagem de cadastro

                      // Campo Matrícula
                      _buildTextField(
                        controller: _matriculaController,
                        labelText: 'Matrícula',
                        hintText: 'Por favor insira a sua matrícula', // Mantendo o hintText original
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),

                      // Campo Descrição do Veículo
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descrição do Veículo',
                            style: TextStyle(
                              fontSize: 16, // Tamanho da fonte do rótulo
                              fontWeight: FontWeight.w500, // Peso da fonte do rótulo
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8), // Espaçamento entre o rótulo e o campo
                          Container(
                            height: 120, // Altura do campo de descrição
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[400]!, width: 1.0), // Borda cinza clara
                              borderRadius: BorderRadius.circular(8), // Borda arredondada
                            ),
                            child: TextFormField(
                              controller: _descricaoController,
                              maxLines: null, // Permite múltiplas linhas
                              expands: true, // Ocupa o espaço disponível verticalmente
                              textAlignVertical: TextAlignVertical.top, // Alinha o texto ao topo
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Faça uma descrição da sua viatura',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[500],
                                ),
                                border: InputBorder.none, // Remove a borda padrão do TextFormField
                                contentPadding: EdgeInsets.all(12), // Padding interno
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, preencha este campo';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),


                      const SizedBox(height: 60), // Espaçamento antes do botão

                      // Botão Adicionar
                      Center(
                        child: Container(
                          width: 200, // Largura do botão (mantido do código original)
                          height: 50,
                          // margin: const EdgeInsets.symmetric(horizontal: 24.0), // A margem já é aplicada no SingleChildScrollView


                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _adicionarVeiculo();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2196F3), // Azul do botão
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25), // Borda arredondada
                              ),
                              elevation: 0, // Sem sombra
                            ),
                            child:
                            (carregando)? const SizedBox(height: 16,width: 17,
                              child: CircularProgressIndicator(color: Colors.black),):
                            Text(
                              'Adicionar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),


                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20), // Espaçamento final
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para construir os campos de texto com o novo estilo
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String hintText = '',
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 16, // Tamanho da fonte do rótulo
            fontWeight: FontWeight.w500, // Peso da fonte do rótulo
            color: Colors.black,
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: 16, // Tamanho da fonte do texto digitado
            color: Colors.black, // Cor do texto digitado
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!, width: 1.0), // Borda cinza clara
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[700]!, width: 1.5), // Borda um pouco mais escura quando focado
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10), // Padding vertical para o texto
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, preencha este campo';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _adicionarVeiculo() {


    setState(() {
      carregando = true;
    });

    VeiculoModel veiculo = VeiculoModel
      (id: Uuid().v1(),
        marca: _marcaController.text,
        matricula: _matriculaController.text,
        descricao: _descricaoController.text,
        proprietario: userId!);

    _veiculoController.addVeiculo(veiculo).then((value){

      setState(() {
        carregando = false;
      });

    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Veículo adicionado com sucesso!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Voltar para a tela anterior
    Navigator.pop(context);
  }
}