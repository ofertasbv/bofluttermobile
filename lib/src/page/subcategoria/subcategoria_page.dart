import 'package:bofluttermobile/src/core/controller/subcategoria_cotroller.dart';
import 'package:bofluttermobile/src/core/model/categoria.dart';
import 'package:bofluttermobile/src/page/subcategoria/subcategoria_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SubCategoriaPage extends StatefulWidget {
  Categoria categoria;

  SubCategoriaPage({Key key, this.categoria}) : super(key: key);

  @override
  _SubCategoriaPageState createState() =>
      _SubCategoriaPageState(categoria: this.categoria);
}

class _SubCategoriaPageState extends State<SubCategoriaPage> {
  _SubCategoriaPageState({this.categoria});

  var subCategoriaController = GetIt.I.get<SubcategoriaCotroller>();

  Categoria categoria;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todas as subcategorias"),
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
                subCategoriaController.getAll();
              },
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
      body: SubCategoriaList(categoria: categoria),
    );
  }
}
