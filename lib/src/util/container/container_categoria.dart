import 'package:bofluttermobile/src/core/controller/categoria_controller.dart';
import 'package:bofluttermobile/src/core/model/categoria.dart';
import 'package:flutter/material.dart';

class ContainerCategoria extends StatelessWidget {
  CategoriaController categoriaController;
  Categoria p;

  ContainerCategoria(this.categoriaController, this.p);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      leading: Container(
        padding: EdgeInsets.all(1),
        child: p.foto != null
            ? CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 20,
                backgroundImage: NetworkImage(
                  "${categoriaController.arquivo + p.foto}",
                ),
              )
            : CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 20,
              ),
      ),
      title: Text(p.nome),
      subtitle: Text("${p.seguimento.nome}"),
      trailing: Container(
        height: 80,
        width: 50,
        child: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text("${p.subCategorias.length}"),
        ),
      ),
    );
  }
}
