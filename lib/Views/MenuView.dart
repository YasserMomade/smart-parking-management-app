import 'package:flutter/material.dart';
import 'package:marcacaovagas/Controllers/UserController.dart';

import 'lista_eventos_screen.dart';
import 'menu_evento_screen.dart';


class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menuuu"),
      ),
      //Drawer
      drawer:  Drawer(
      child: ListView(
        children: [
          //btn deslogar
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Sair"),
            onTap: (){
              UserController().logOut();
            },

          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Tela Raul 2"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder:
                      (_) => ListaEventosScreen()));
            },

          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Tela Raul 1"),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder:
                      (_) => MenuEventoScreen()));
            },

          ),

        ],
      ),
        //Botao deslogar

      ),
    );
  }
}
