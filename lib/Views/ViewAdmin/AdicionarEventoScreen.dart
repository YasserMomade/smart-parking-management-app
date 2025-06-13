import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Controllers/evento_controller.dart';
import '../../Models/evento_model.dart';

class AdicionarEventoScreen extends StatefulWidget {
  const AdicionarEventoScreen({super.key});

  @override
  State<AdicionarEventoScreen> createState() => _AdicionarEventoScreenState();
}

class _AdicionarEventoScreenState extends State<AdicionarEventoScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController horaInicioController = TextEditingController();
  final TextEditingController horaFimController = TextEditingController();
  final TextEditingController precoController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController vagasController = TextEditingController();


  String? categoriaSelecionada;

  final List<String> categorias = [
    'Supermercado',
    'Espetaculo',
    'Parque',
    'Aeroporto',
    'Estadio',
  ];

  Future<void> _selecionarData() async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (dataSelecionada != null) {
      setState(() {
        dataController.text =
        "${dataSelecionada.day.toString().padLeft(2, '0')}/${dataSelecionada.month.toString().padLeft(2, '0')}/${dataSelecionada.year}";
      });
    }
  }

  Future<void> _selecionarHora(TextEditingController controller) async {
    TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (hora != null) {
      setState(() {
        controller.text = hora.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Evento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome do Evento'),
                validator: (value) =>
                value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              DropdownButtonFormField<String>(
                value: categoriaSelecionada,
                items: categorias.map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    categoriaSelecionada = value;
                  });
                },
                decoration:
                const InputDecoration(labelText: 'Categoria do Evento'),
                validator: (value) =>
                value == null ? 'Selecione uma categoria' : null,
              ),
              TextFormField(
                controller: localController,
                decoration: const InputDecoration(labelText: 'Local do Evento'),
                validator: (value) =>
                value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: dataController,
                readOnly: true,
                onTap: _selecionarData,
                decoration: const InputDecoration(labelText: 'Data'),
                validator: (value) =>
                value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: horaInicioController,
                readOnly: true,
                onTap: () => _selecionarHora(horaInicioController),
                decoration:
                const InputDecoration(labelText: 'Hora de Início'),
                validator: (value) =>
                value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: horaFimController,
                readOnly: true,
                onTap: () => _selecionarHora(horaFimController),
                decoration:
                const InputDecoration(labelText: 'Hora de Fim'),
                validator: (value) =>
                value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: precoController,
                decoration:
                const InputDecoration(labelText: 'Preço por Hora'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: vagasController,
                decoration: const InputDecoration(labelText: 'Número de Vagas'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Campo obrigatório' : null,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final evento = EventoModel(
                          titulo: nomeController.text,
                          tipo: categoriaSelecionada!,
                          data: DateFormat('dd/MM/yyyy').parse(dataController.text),
                          horaInicio: horaInicioController.text,
                          horaFim: horaFimController.text,
                          valor: double.tryParse(precoController.text) ?? 0.0,
                          id: null,
                          vagas: int.tryParse(vagasController.text) ?? 0,
                          local: localController.text
                      );

                      await EventoController().adicionarEvento(evento);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Evento adicionado com sucesso!')),
                      );

                      nomeController.clear();
                      dataController.clear();
                      horaInicioController.clear();
                      horaFimController.clear();
                      precoController.clear();
                      vagasController.clear();
                      localController.clear();
                      setState(() => categoriaSelecionada = null);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                            Text('Erro ao adicionar evento: $e')),
                      );
                    }
                  }
                },
                child: const Text('Salvar Evento'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
