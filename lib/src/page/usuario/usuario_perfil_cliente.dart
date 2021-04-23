import 'dart:io';

import 'package:bofluttermobile/src/core/controller/cliente_controller.dart';
import 'package:bofluttermobile/src/core/controller/usuario_controller.dart';
import 'package:bofluttermobile/src/core/model/cliente.dart';
import 'package:bofluttermobile/src/page/cliente/cliente_create_page.dart';
import 'package:bofluttermobile/src/util/snackbar/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UsuarioPerfilCliente extends StatefulWidget {
  Cliente cliente;

  UsuarioPerfilCliente({Key key, this.cliente}) : super(key: key);

  @override
  _UsuarioPerfilClienteState createState() =>
      _UsuarioPerfilClienteState(p: this.cliente);
}

class _UsuarioPerfilClienteState extends State<UsuarioPerfilCliente> {
  _UsuarioPerfilClienteState({this.p});

  var usuarioController = GetIt.I.get<UsuarioController>();
  var clienteController = GetIt.I.get<ClienteController>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Cliente p;
  File file;
  bool isEnabledEnviar = false;
  bool isEnabledDelete = false;

  @override
  void initState() {
    if (p == null) {
      p = Cliente();
    }
    super.initState();
  }

  enableButton() {
    setState(() {
      isEnabledEnviar = true;
    });
  }

  disableButton() {
    setState(() {
      isEnabledDelete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalScaffold.instance.scaffkey,
      appBar: AppBar(
        title: Text("Meu perfil"),
        elevation: 0,
        actions: [
          CircleAvatar(
            foregroundColor: Theme.of(context).accentColor,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: buildListView(context),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 150,
          color: Theme.of(context).primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(1),
                child: GestureDetector(
                  onTap: () {
                    // openBottomSheet(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Icon(Icons.person),
                    radius: 30,
                  ),
                ),
              ),
              SizedBox(height: 0),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Text(
                  "Meu perfil",
                  style: TextStyle(
                    color: Colors.grey[100],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                height: 30,
                child: Text(
                  "SOU CLIENTE",
                  style: TextStyle(
                    color: Colors.grey[100],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text("Cupom de desconto"),
                subtitle: Text("Resgate seu cupom de desconto"),
                leading: CircleAvatar(
                  child: Icon(Icons.games_outlined),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ClienteCreatePage();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Minha lista de desejo"),
                subtitle: Text("Todos os seus desejos"),
                leading: CircleAvatar(
                  child: Icon(Icons.list_alt_outlined),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ClienteCreatePage();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Dados pesoais"),
                subtitle: Text("Alterar senha, login, email, e dados pessoais"),
                leading: CircleAvatar(
                  child: Icon(Icons.account_circle_outlined),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ClienteCreatePage();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Endereço de cliente"),
                subtitle: Text("Altere seu endereço"),
                leading: CircleAvatar(
                  child: Icon(Icons.location_on_outlined),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ClienteCreatePage();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Atedimento ao cliente"),
                subtitle: Text("Envie um e-mail"),
                leading: CircleAvatar(
                  child: Icon(Icons.email_outlined),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ClienteCreatePage();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Sair"),
                subtitle: Text("Acesse com outra conta"),
                leading: CircleAvatar(
                  child: Icon(Icons.logout),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ClienteCreatePage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
