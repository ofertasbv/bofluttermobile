import 'package:bofluttermobile/src/core/controller/categoria_controller.dart';
import 'package:bofluttermobile/src/core/model/seguimento.dart';
import 'package:bofluttermobile/src/page/categoria/categoria_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CategoriaPage extends StatefulWidget {
  Seguimento s;

  CategoriaPage({Key key, this.s}) : super(key: key);

  @override
  _CategoriaPageState createState() => _CategoriaPageState(seguimento: this.s);
}

class _CategoriaPageState extends State<CategoriaPage> {
  var categoriaController = GetIt.I.get<CategoriaController>();

  _CategoriaPageState({this.seguimento});

  Seguimento seguimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todos os departamentos"),
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
          SizedBox(width: 5),
        ],
      ),
      body: CategoriaList(s: seguimento),
    );
  }
}
