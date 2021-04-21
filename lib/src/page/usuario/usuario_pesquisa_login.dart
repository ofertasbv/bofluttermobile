import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:bofluttermobile/src/core/controller/usuario_controller.dart';
import 'package:bofluttermobile/src/core/model/usuario.dart';
import 'package:bofluttermobile/src/page/usuario/usuario_recuperar_senha.dart';
import 'package:bofluttermobile/src/util/dialogs/dialogs.dart';
import 'package:bofluttermobile/src/util/validador/validador_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class UsuarioPesquisaLogin extends StatefulWidget {
  Usuario usuario;

  UsuarioPesquisaLogin({Key key, this.usuario}) : super(key: key);

  @override
  _UsuarioPesquisaLoginState createState() =>
      _UsuarioPesquisaLoginState(u: this.usuario);
}

class _UsuarioPesquisaLoginState extends State<UsuarioPesquisaLogin>
    with LoginValidators {
  var usuarioController = GetIt.I.get<UsuarioController>();
  Dialogs dialogs = Dialogs();

  Usuario u;
  File file;
  bool isButtonDesable = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  _UsuarioPesquisaLoginState({this.u});

  var emailController = TextEditingController();
  var confirmaEmailController = TextEditingController();

  @override
  void initState() {
    usuarioController.getAll();
    if (u == null) {
      u = Usuario();
    }

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
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Text("Busca por login"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 0, right: 0, top: 0),
        child: Card(
          child: Observer(
            builder: (context) {
              if (usuarioController.dioError == null) {
                return buildListViewForm(context);
              } else {
                print("Erro: ${usuarioController.mensagem}");
                return buildListViewForm(context);
              }
            },
          ),
        ),
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          padding: EdgeInsets.all(10),
          child: ListTile(
            title: Text("Buscar login"),
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        onSaved: (value) => u.email = value.trim(),
                        validator: validateEmail,
                        decoration: InputDecoration(
                          labelText: "Entre com e-mail",
                          hintText: "example@email.com",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        keyboardType: TextInputType.text,
                        maxLength: 50,
                        maxLines: 1,
                      ),
                    ],
                  ),
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
                dialogs.information(context, "verificando login");
                Timer(Duration(seconds: 3), () {
                  usuarioController.getEmail(u.email);
                  Navigator.of(context).pop();
                  buildPush(context);
                });
              }
            },
          ),
        ),
      ],
    );
  }

  buildPush(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UsuarioRecuperarSenha(usuario: u),
      ),
    );
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
