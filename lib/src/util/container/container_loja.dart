import 'package:bofluttermobile/src/core/controller/loja_controller.dart';
import 'package:bofluttermobile/src/core/model/loja.dart';
import 'package:flutter/material.dart';

class ContainerLoja extends StatelessWidget {
  LojaController lojaController;
  Loja p;

  ContainerLoja(this.lojaController, this.p);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      leading: Container(
        padding: EdgeInsets.all(1),
        child: p.foto != null
            ? CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 20,
                backgroundImage: NetworkImage(
                  "${lojaController.arquivo + p.foto}",
                ),
              )
            : CircleAvatar(
                radius: 20,
                child: Icon(Icons.location_on_outlined),
              ),
      ),
      title: Text(p.nome),
      subtitle: Text("${p.telefone}"),
      trailing: Container(
        height: 80,
        width: 50,
        child: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text("${p.produtos.length}"),
        ),
      ),
    );
  }
}
