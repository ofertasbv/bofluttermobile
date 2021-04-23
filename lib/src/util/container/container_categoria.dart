import 'dart:math';

import 'package:bofluttermobile/src/core/controller/categoria_controller.dart';
import 'package:bofluttermobile/src/core/model/categoria.dart';
import 'package:flutter/material.dart';

class ContainerCategoria extends StatelessWidget {
  CategoriaController categoriaController;
  Categoria p;

  ContainerCategoria(this.categoriaController, this.p);

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: false,
      leading: Container(
        padding: EdgeInsets.all(1),
        child: p.foto != null
            ? CircleAvatar(
                backgroundColor:
                    Color((random.nextDouble() * 0xFFFFFF).toInt() << 0)
                        .withOpacity(1),
                radius: 25,
                backgroundImage: NetworkImage(
                  "${categoriaController.arquivo + p.foto}",
                ),
              )
            : CircleAvatar(
                backgroundColor:
                    Color((random.nextDouble() * 0xFFFFFF).toInt() << 0)
                        .withOpacity(1),
                radius: 25,
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
