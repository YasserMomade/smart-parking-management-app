import 'package:flutter/material.dart';
import 'adicionar_Viatura.dart';

class telaMenu extends StatelessWidget {
  const telaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 24,
                    ),
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

              const SizedBox(height: 20),

              // Welcome Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Bem Vindo senhor/a Raul!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Events Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Eventos da semana',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Acco para "Ver mais"
                      },
                      child: Row(
                        children: [
                          Text(
                            'Ver mais',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2196F3),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF2196F3),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Eventos da semana - overflow (scroll horizontal)
              SizedBox(
                height: 155,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    final events = [
                      {'location': 'Matola,parque dos poetas', 'name': 'Picasso Eventos', 'date': '2/03/2025'},
                      {'location': 'Maputo,Maxaqu', 'name': 'sabor do ver', 'date': '2/03/2025'},
                    ];

                    return Padding(
                      padding: EdgeInsets.only(right: index < events.length - 1 ? 12 : 0),
                      child: _cartaoEventos(
                        events[index]['location']!,
                        events[index]['name']!,
                        events[index]['date']!,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Menu Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Menu Grid (com quadrados maiores)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.9,
                  children: [
                    _cartaoMenu(
                      icon: Icons.search,
                      title: 'Marcar vaga',
                      onTap: () {},
                    ),
                    _cartaoMenu(
                      icon: Icons.add,
                      title: 'Adicionar veículo',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdicionarViatura(),
                          ),
                        );
                      },
                    ),
                    _cartaoMenu(
                      icon: Icons.assignment,
                      title: 'Lista de veículo',
                      onTap: () {},
                    ),
                    _cartaoMenu(
                      icon: Icons.article_outlined,
                      title: 'Histórico',
                      onTap: () {},
                    ),
                    _cartaoMenu(
                      icon: Icons.error_outline, // Ícone de exclamação da imagem
                      title: 'Reclamações',
                      onTap: () {},
                    ),
                    _cartaoMenu(
                      icon: Icons.manage_accounts, // Ícone de gestão (pessoa com engrenagem) da imagem
                      title: 'Gestão',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Services Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Nossos Serviços',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Service Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Maputo, Hackthon 2025',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Estivemos a dar cobertura no estacionamento da FCTI da USTM no dia 23 de abril ...........',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.visibility_outlined, // Ícone de olho
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cartaoEventos(String localizacao, String nomeEvento, String data) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Cabecalho do cartao de evento
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                localizacao,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centralza o conteudo verticalmente
                children: [

                  _iconeCalendario(),
                  const SizedBox(height: 8),
                  Text(
                    nomeEvento,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Adiciona "..." se o texto for muito longo
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconeCalendario() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFFFF9800),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.calendar_today,
        color: Colors.black,
        size: 25,
      ),
    );
  }

  Widget _cartaoMenu({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 28,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}