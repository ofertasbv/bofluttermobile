import 'package:bofluttermobile/src/core/controller/categoria_controller.dart';
import 'package:bofluttermobile/src/page/categoria/categoria_list.dart';
import 'package:bofluttermobile/src/page/seguimento/seguimento_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SeguimentoPage extends StatefulWidget {
  @override
  _SeguimentoPageState createState() => _SeguimentoPageState();
}

class _SeguimentoPageState extends State<SeguimentoPage> {
  var categoriaController = GetIt.I.get<CategoriaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todos os seguimentos"),
        elevation: 0,
        actions: [
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.grey[200],
              ),
              onPressed: () {
                categoriaController.getAll();
              },
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SeguimentoList(),
    );
  }
}
