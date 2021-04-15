import 'package:bofluttermobile/src/core/controller/subcategoria_cotroller.dart';
import 'package:bofluttermobile/src/core/model/categoria.dart';
import 'package:bofluttermobile/src/core/model/subcategoria.dart';
import 'package:flutter/material.dart';

class ContainerSubCategoria extends StatelessWidget {
  SubcategoriaCotroller categoriaController;
  SubCategoria p;

  ContainerSubCategoria(this.categoriaController, this.p);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      leading: Container(
        padding: EdgeInsets.all(1),
        child: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.list_alt_outlined),
          radius: 20,
        ),
      ),
      title: Text(p.nome),
      subtitle: Text("${p.categoria.nome}"),
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
