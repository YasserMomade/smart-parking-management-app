import 'package:flutter/material.dart';
import 'package:marcacaovagas/Controllers/UserController.dart';


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

          )
        ],
      ),
        //Botao deslogar

      ),
    );
  }
}
