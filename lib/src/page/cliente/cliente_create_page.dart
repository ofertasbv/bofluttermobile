import 'dart:async';
import 'dart:io';

import 'package:bofluttermobile/src/core/controller/cliente_controller.dart';
import 'package:bofluttermobile/src/core/model/cliente.dart';
import 'package:bofluttermobile/src/core/model/endereco.dart';
import 'package:bofluttermobile/src/core/model/usuario.dart';
import 'package:bofluttermobile/src/page/usuario/usuario_login_page.dart';
import 'package:bofluttermobile/src/util/dialogs/dialogs.dart';
import 'package:bofluttermobile/src/util/validador/validador_pessoa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ClienteCreatePage extends StatefulWidget {
  Cliente cliente;

  ClienteCreatePage({Key key, this.cliente}) : super(key: key);

  @override
  _ClienteCreatePageState createState() =>
      _ClienteCreatePageState(p: this.cliente);
}

class _ClienteCreatePageState extends State<ClienteCreatePage>
    with ValidadorPessoa {
  var clienteController = GetIt.I.get<ClienteController>();
  Dialogs dialogs = Dialogs();

  Cliente p;
  Endereco e;
  Usuario u;

  _ClienteCreatePageState({this.p});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime dataAtual = DateTime.now();
  String tipoPessoa;
  String sexo;
  String valorSlecionado;
  File file;

  var senhaController = TextEditingController();
  var confirmaSenhaController = TextEditingController();

  @override
  void initState() {
    if (p == null) {
      p = Cliente();
      u = Usuario();
      e = Endereco();
    } else {
      u = p.usuario;
    }

    tipoPessoa = "FISICA";
    sexo = "MASCULINO";
    super.initState();
  }

  Controller controller;

  @override
  void didChangeDependencies() {
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
        title: p.nome == null ? Text("Cadastro de cliente") : Text(p.nome),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 0, right: 0, top: 0),
        child: Card(
          child: Observer(
            builder: (context) {
              if (clienteController.dioError == null) {
                return buildListViewForm(context);
              } else {
                print("Erro: ${clienteController.mensagem}");
                return buildListViewForm(context);
              }
            },
          ),
        ),
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    var focus = FocusScope.of(context);
    var dateFormat = DateFormat('dd-MM-yyyy');

    var maskFormatterCelular = new MaskTextInputFormatter(
        mask: '(##)#####-####', filter: {"#": RegExp(r'[0-9]')});

    var maskFormatterCPF = new MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

    p.usuario = u;

    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          padding: EdgeInsets.all(10),
          child: ListTile(
            title: Text("faça seu cadastro, é rapido e seguro"),
            trailing: Icon(Icons.person_outline),
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
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    initialValue: p.nome,
                    onSaved: (value) => p.nome = value,
                    validator: (value) =>
                        value.isEmpty ? "Preencha o nome completo" : null,
                    decoration: InputDecoration(
                      labelText: "Nome completo",
                      hintText: "nome",
                      suffixIcon: Icon(Icons.close),
                    ),
                    onEditingComplete: () => focus.nextFocus(),
                    keyboardType: TextInputType.text,
                    maxLength: 50,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    initialValue: p.cpf,
                    onSaved: (value) => p.cpf = value,
                    validator: (value) =>
                        value.isEmpty ? "Preencha o cpf" : null,
                    decoration: InputDecoration(
                      labelText: "cpf",
                      hintText: "cpf",
                      suffixIcon: Icon(Icons.close),
                    ),
                    onEditingComplete: () => focus.nextFocus(),
                    inputFormatters: [maskFormatterCPF],
                    keyboardType: TextInputType.number,
                    maxLength: 14,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    initialValue: p.telefone,
                    onSaved: (value) => p.telefone = value,
                    validator: (value) =>
                        value.isEmpty ? "Preencha o telefone" : null,
                    decoration: InputDecoration(
                      labelText: "Telefone",
                      hintText: "Telefone celular",
                      suffixIcon: Icon(Icons.close),
                    ),
                    onEditingComplete: () => focus.nextFocus(),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [maskFormatterCelular],
                    maxLength: 50,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    initialValue: p.usuario.email,
                    onSaved: (value) => p.usuario.email = value,
                    validator: validateEmail,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                      suffixIcon: Icon(Icons.close),
                    ),
                    onEditingComplete: () => focus.nextFocus(),
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: senhaController,
                    onSaved: (value) => p.usuario.senha = value,
                    validator: validateSenha,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      hintText: "Senha",
                      suffixIcon: IconButton(
                        icon: clienteController.senhaVisivel == true
                            ? Icon(Icons.visibility_outlined,
                                color: Colors.grey)
                            : Icon(Icons.visibility_off_outlined,
                                color: Colors.grey),
                        onPressed: () {
                          clienteController.visualizarSenha();
                        },
                      ),
                    ),
                    onEditingComplete: () => focus.nextFocus(),
                    keyboardType: TextInputType.text,
                    obscureText: !clienteController.senhaVisivel,
                    maxLength: 8,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: confirmaSenhaController,
                    validator: validateSenha,
                    decoration: InputDecoration(
                      labelText: "Confirma senha",
                      hintText: "Confirma senha",
                      suffixIcon: IconButton(
                        icon: clienteController.senhaVisivel == true
                            ? Icon(Icons.visibility_outlined,
                                color: Colors.grey)
                            : Icon(Icons.visibility_off_outlined,
                                color: Colors.grey),
                        onPressed: () {
                          clienteController.visualizarSenha();
                        },
                      ),
                    ),
                    onEditingComplete: () => focus.nextFocus(),
                    keyboardType: TextInputType.text,
                    obscureText: !clienteController.senhaVisivel,
                    maxLength: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.all(15),
          child: RaisedButton.icon(
            label: Text("Enviar formulário"),
            icon: Icon(Icons.check),
            onPressed: () {
              if (controller.validate()) {
                if (p.id == null) {
                  if (senhaController.text != confirmaSenhaController.text) {
                    showSnackbar(context, "senha diferentes");
                    print("senha diferentes");
                  } else {
                    dialogs.information(context, "prepando para o cadastro...");
                    Timer(Duration(seconds: 3), () {
                      print("Pessoa: ${p.tipoPessoa}");
                      print("Nome: ${p.nome}");
                      print("CPF: ${p.cpf}");
                      print("Telefone: ${p.telefone}");
                      print("Email: ${p.usuario.email}");
                      print("Senha: ${p.usuario.senha}");

                      clienteController.create(p).then((value) {
                        print("resultado : ${value}");
                      });
                      buildPush(context);
                    });
                  }
                } else {
                  if (p.usuario.senha == p.usuario.confirmaSenha) {
                    showSnackbar(context, "senha diferentes");
                    print("senha diferentes");
                  } else {
                    dialogs.information(
                        context, "preparando para o alteração...");
                    Timer(Duration(seconds: 3), () {
                      print("Pessoa: ${p.tipoPessoa}");
                      print("Nome: ${p.nome}");
                      print("CPF: ${p.cpf}");
                      print("Telefone: ${p.telefone}");
                      print("Email: ${p.usuario.email}");
                      print("Senha: ${p.usuario.senha}");

                      clienteController.update(p.id, p);
                      buildPush(context);
                    });
                  }
                }
              }
            },
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Já tem uma conta ? "),
              GestureDetector(
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UsuarioLoginPage();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  buildPush(BuildContext context) {
    // Navigator.of(context).pop();
    // return Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ClientePage(),
    //   ),
    // );
  }

  confirmaSenha() {
    print("senha diferentes");
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
