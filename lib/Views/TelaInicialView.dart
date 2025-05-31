import 'package:flutter/material.dart';
import 'package:marcacaovagas/Views/Entrar_cadastrarView.dart';
import 'package:marcacaovagas/main.dart';


class Telainicialview extends StatelessWidget {
  const Telainicialview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0052D4),
                Color(0xFF4364F7),
                Color(0xFF6FB1FC),
              ],
            ),
          ),

    child: SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                //Logo
                const SizedBox(height: 25,),

                Image.asset("assets/logo.png"),

                //Foto
                Image.asset("assets/ImgPrincipal.png"),
                const SizedBox(height: 25,),
                //Texto
                Text(
                  "Bem-vindo!",
                  style: TextStyle(fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Acesse sua conta ou crie uma nova Conta",
                  style: TextStyle(fontSize: 18,
                      color: Colors.white
                  ),
                ),

                const SizedBox(height: 25,),
                // entrar/criar conta

                Row(
                  children: [

                    // Botao entrar
                    ElevatedButton(
                        onPressed: (){

                          Navigator.push(context,
                          MaterialPageRoute(builder: (_)=>
                          EntrarCadastrarview(queroEntrar: true)));

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          minimumSize: Size(140, 50),
                        ),
                        child: Text("Entrar",
                          style: TextStyle(color: Colors.white),)
                    ),

                    SizedBox(width: 16),
                    //Botao criar conta
                    ElevatedButton(
                        onPressed: (){

                          Navigator.push(context,
                              MaterialPageRoute(builder:
                              (_) => EntrarCadastrarview(queroEntrar: false)));

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: Size(140, 50),
                          side: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        child: Text("Criar conta",
                          style: TextStyle(color: Colors.blue),
                        )
                    ),
                  ],
                ),

              ],
            ),
          )


              ),
        ) ,
    ),);
  }
}
