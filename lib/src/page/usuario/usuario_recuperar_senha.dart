import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:bofluttermobile/src/core/controller/usuario_controller.dart';
import 'package:bofluttermobile/src/core/model/usuario.dart';
import 'package:bofluttermobile/src/util/dialogs/dialogs.dart';
import 'package:bofluttermobile/src/util/validador/validador_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class UsuarioRecuperarSenha extends StatefulWidget {
  Usuario usuario;

  UsuarioRecuperarSenha({Key key, this.usuario}) : super(key: key);

  @override
  _UsuarioRecuperarSenhaState createState() =>
      _UsuarioRecuperarSenhaState(u: this.usuario);
}

class _UsuarioRecuperarSenhaState extends State<UsuarioRecuperarSenha>
    with LoginValidators {
  var usuarioController = GetIt.I.get<UsuarioController>();
  Dialogs dialogs = Dialogs();

  Usuario u;
  File file;
  bool isButtonDesable = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _UsuarioRecuperarSenhaState({this.u});

  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  var confirmaSenhaController = TextEditingController();

  @override
  void initState() {
    usuarioController.getAll();
    if (u == null) {
      u = Usuario();
    }
    u = usuarioController.usuarioSelecionado;
    super.initState();
  }

  Controller controller;

  @override
  didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  showSnackbar(BuildContext context, String content) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recuperar senha"),
      ),
      body: Observer(
        builder: (context) {
          if (usuarioController.dioError == null) {
            return buildListViewForm(context);
          } else {
            print("Erro: ${usuarioController.mensagem}");
            return buildListViewForm(context);
          }
        },
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    var focus = FocusScope.of(context);

    if (usuarioController.usuarioSelecionado != null) {
      u = usuarioController.usuarioSelecionado;
      emailController.text = usuarioController.usuarioSelecionado.email;
    }

    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(10),
          child: ListTile(
            title: Text("Cadastrar nova senha"),
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(30),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  onSaved: (value) => u.email = value.trim(),
                  validator: validateEmail,
                  decoration: InputDecoration(
                    labelText: "Entre com e-mail",
                    hintText: "example@email.com",
                    suffixIcon: Icon(Icons.close),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  onEditingComplete: () => focus.nextFocus(),
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  maxLines: 1,
                ),
                TextFormField(
                  controller: senhaController,
                  onSaved: (value) => u.senha = value.trim(),
                  validator: validateSenha,
                  decoration: InputDecoration(
                    labelText: "Digite nova senha",
                    hintText: "Nova senha",
                    suffixIcon: IconButton(
                      icon: usuarioController.senhaVisivel == true
                          ? Icon(Icons.visibility_outlined, color: Colors.grey)
                          : Icon(Icons.visibility_off_outlined,
                              color: Colors.grey),
                      onPressed: () {
                        usuarioController.visualizarSenha();
                      },
                    ),
                  ),
                  onEditingComplete: () => focus.nextFocus(),
                  keyboardType: TextInputType.text,
                  obscureText: !usuarioController.senhaVisivel,
                  maxLength: 8,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: confirmaSenhaController,
                  validator: validateSenha,
                  decoration: InputDecoration(
                    labelText: "Confirma a senha",
                    hintText: "Confirma senha",
                    suffixIcon: IconButton(
                      icon: usuarioController.senhaVisivel == true
                          ? Icon(Icons.visibility_outlined, color: Colors.grey)
                          : Icon(Icons.visibility_off_outlined,
                              color: Colors.grey),
                      onPressed: () {
                        usuarioController.visualizarSenha();
                      },
                    ),
                  ),
                  onEditingComplete: () => focus.nextFocus(),
                  keyboardType: TextInputType.text,
                  obscureText: !usuarioController.senhaVisivel,
                  maxLength: 8,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.all(30),
          child: RaisedButton.icon(
            label: Text("Enviar formulário"),
            icon: Icon(Icons.check),
            onPressed: () {
              if (controller.validate()) {
                if (senhaController.text != confirmaSenhaController.text) {
                  showSnackbar(context, "senha diferentes");
                  print("senha diferentes");
                } else {
                  dialogs.information(context, "preparando para o alteração");
                  Timer(Duration(seconds: 3), () {
                    usuarioController.update(u.id, u);
                    Navigator.of(context).pop();
                    buildPush(context);
                  });
                }
              }
            },
          ),
        ),
      ],
    );
  }

  buildPush(BuildContext context) {
    // return Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => UsuarioPage(),
    //   ),
    // );
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();
  bool validate() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
}
