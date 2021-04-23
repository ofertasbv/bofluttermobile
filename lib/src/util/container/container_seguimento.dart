import 'package:bofluttermobile/src/core/controller/categoria_controller.dart';
import 'package:bofluttermobile/src/core/controller/seguimento_controller.dart';
import 'package:bofluttermobile/src/core/model/categoria.dart';
import 'package:bofluttermobile/src/core/model/seguimento.dart';
import 'package:flutter/material.dart';

class ContainerSeguimento extends StatelessWidget {
  SeguimentoController seguimentoController;
  Seguimento p;

  ContainerSeguimento(this.seguimentoController, this.p);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      leading: Container(
        padding: EdgeInsets.all(1),
        child: CircleAvatar(
          backgroundColor: Colors.grey[300],
          radius: 25,
          child: Icon(Icons.wallet_giftcard_outlined),
        ),
      ),
      title: Text(p.nome),
      subtitle: Text("${p.id}"),
      trailing: Container(
        height: 80,
        width: 50,
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: Text("${p.categorias.length}"),
        ),
      ),
    );
  }
}
