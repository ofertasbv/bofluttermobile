import 'package:bofluttermobile/src/page/usuario/usuario_login.dart';
import 'package:bofluttermobile/src/util/snackbar/snackbar_global.dart';
import 'package:flutter/material.dart';

class UsuarioLoginPage extends StatefulWidget {
  @override
  _UsuarioLoginPageState createState() => _UsuarioLoginPageState();
}

class _UsuarioLoginPageState extends State<UsuarioLoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalScaffold.instance.scaffkey,
      appBar: AppBar(
        elevation: 0,
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 0, right: 0, top: 0),
        height: 700,
        child: Card(child: UsuarioLogin()),
      ),
    );
  }
}
