import 'package:flutter/material.dart';
import 'package:marcacaovagas/Controllers/UserController.dart';
import 'package:marcacaovagas/Models/userModel.dart';
import 'package:marcacaovagas/Views/MenuView.dart';
import 'package:marcacaovagas/_cocum/input.dart';
import 'package:marcacaovagas/_cocum/SnackBar.dart';
import 'package:marcacaovagas/Views/TelaInicialView.dart';


class EntrarCadastrarview extends StatefulWidget {
  final bool queroEntrar;
  const EntrarCadastrarview({super.key,
    required this.queroEntrar});

  @override
  State<EntrarCadastrarview> createState() => _EntrarCadastrarviewState();
}

class _EntrarCadastrarviewState extends State<EntrarCadastrarview> {

  late bool queroEntrar;
  bool _textoOculto = false;

  // Chave do formulario
  final _formKey = GlobalKey<FormState>();

  //instancia do controller user
  final userController = UserController();

  TextEditingController _emailctrl = TextEditingController();
  TextEditingController _nomectrl = TextEditingController();
  TextEditingController _numctrl = TextEditingController();
  TextEditingController _senhacrtl = TextEditingController();
  TextEditingController _confSenhactrl = TextEditingController();

  void _mudarVisibilidadeSenha() {
    setState(() {
      _textoOculto = !_textoOculto;
    });
  }

// Para saber se quer entrar ou cadastrar
  @override
  void initState() {
    super.initState();
    queroEntrar = widget.queroEntrar;
    _mudarVisibilidadeSenha();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:  Colors.white,

      body: Stack(
        children: [



          Padding(
            padding: const EdgeInsets.all(16.0),
            //Formulario ENtrar/ login

            child: Form(
            key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,


                      children: [

                        //Logo
                        Padding(
                          padding: const EdgeInsets.only(top: 30,bottom: 100),
                          child:
                          Image.asset("assets/logo.png"),

                        ),



                        //Input Nome
                        // So estara disponovel se quiser criar conta
                        Visibility(visible: !queroEntrar,
                            child: Column(
                              children: [
                                // Nome
                                TextFormField(
                                  controller: _nomectrl,
                                  decoration: getInput(label: "Nome", senha: false, textoOculto: false, senhaVisivel: (){}),

                                ),
                              ],
                            )),

                        //Email
                        TextFormField(
                          controller: _emailctrl,
                          decoration: getInput(label: "E-mail", senha: false, textoOculto: false, senhaVisivel: (){}),

                          //Tratamento de erros

                          validator: (String? value) {

                            if(value == null){
                              return "O email  nao pode ser vazio";
                            } if(value.length < 5){
                              return "O email e muito curto";
                            }
                            if(!value.contains("@")){
                              return "Digite um email valido Ex.: abc@gmail.com";
                            }
                            return null;
                          },

                        ),

                        // So estara disponovel se quiser criar conta
                        Visibility(visible: !queroEntrar,
                            child: Column(
                              children: [
                                //numero
                                TextFormField(
                            controller: _numctrl,
                                  decoration: getInput(label: "Numero de celular", senha: false, textoOculto: false, senhaVisivel: (){}),
                                  keyboardType: TextInputType.number,
                                ),

                              ],
                            )),


                        //senha
                        TextFormField(
                          controller: _senhacrtl,
                          obscureText: _textoOculto,
                          decoration: getInput(label: "Digeite a senha", senha: true, textoOculto: _textoOculto, senhaVisivel: _mudarVisibilidadeSenha),
                        ),

                        // So estara disponovel se quiser criar conta
                        Visibility(visible: !queroEntrar,
                            child: Column(
                              children: [
                                //numero
                                //Confirmar senha
                                TextFormField(
                                  controller: _confSenhactrl,
                                  obscureText: _textoOculto,
                                  decoration: getInput(label: "Confirmar  senha", senha: true, textoOculto: _textoOculto, senhaVisivel: _mudarVisibilidadeSenha),
                                ),

                              ],
                            )),


                        //Ja tem uma conta?// entrar
                        SizedBox(height: 20,),

                        Visibility(visible: queroEntrar,
                          child: Row(
                          children: [
                            Text("Esqueceu palavra passe? ",
                            style: TextStyle(color: Colors.black),),

                       GestureDetector(
                         onTap: (){
                           Navigator.push(context,
                               MaterialPageRoute(builder:
                                   (_) => EntrarCadastrarview(queroEntrar: false)));
                           Navigator.push(context,
                               MaterialPageRoute(builder:
                                   (_) => EntrarCadastrarview(queroEntrar: false)));
                         },

                         child: Text("Recuperar",
                            style: TextStyle(color: Colors.blueAccent)
                           ,),)
                          ],
                        ),),

                        SizedBox(height: 50 ),

                        // Botao// entrar/logar
                        ElevatedButton(
                           onPressed:(){

                             Btn_cadastrarUser();

                           },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: Size(180, 50),
                              side: BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            child: Text((queroEntrar)?"Entrar":"Cadastrar",
                              style: TextStyle(color: Colors.white),
                            )
                        ),

                        SizedBox(height: 100,),

                        // Ja tem uma conta// Ainda nao tem uma conta

                        Center(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text( (queroEntrar)? "Nao tens uma conta?" : "Ja tens uma conta ?" ,
                                style: TextStyle(color: Colors.black),),

                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    queroEntrar = !queroEntrar;
                                    _emailctrl.clear();
                                  });
                                },

                                child: Text( (queroEntrar)?" Criar Conta":" Entrar",
                                  style: TextStyle(color: Colors.blueAccent)
                                  ,),)
                            ],
                          ),
                        ),
                        
                      ],

                    ),


                  ),



            )
            ),

          )
    ],
      ),
    );
  }

  Btn_cadastrarUser()  {

    //Validador dos inputs
    if(_formKey.currentState!.validate()){
      if(queroEntrar){

        final utilizador = UserModel(
            nome: '',
            email: _emailctrl.text,
            senha: _senhacrtl.text,
            numero: 0,
        );

        userController.logarUser(user: utilizador)
            .then(
                (String? erro) {
              if (erro != null) {
                // Voltou com erro(Ocorreu um erro no cadastro)
                mostrarSnackBar(context: context, txt: erro);
              }
            });

      }else {

        final utilizador = UserModel(
            nome: _nomectrl.text,
            email: _emailctrl.text,
            senha: _senhacrtl.text,
            numero: int.parse(_numctrl.text));

        userController.cadastrarUser(utilizador).then(

                (String? erro) {
              if (erro != null) {
                // Voltou com erro(Ocorreu um erro no cadastro)
                mostrarSnackBar(context: context, txt: erro);
              }
            });
      }

    }


    else{
      print("erro desconhecido");
    }

  }
}
