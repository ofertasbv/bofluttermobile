import 'package:bofluttermobile/src/core/controller/subcategoria_cotroller.dart';
import 'package:bofluttermobile/src/core/model/categoria.dart';
import 'package:bofluttermobile/src/core/model/subcategoria.dart';
import 'package:bofluttermobile/src/page/subcategoria/subcategoria_list.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
          Observer(
            builder: (context) {
              List<SubCategoria> categorias =
                  subCategoriaController.subCategorias.value;
              if (subCategoriaController.subCategorias.error != null) {
                return Text("Não foi possível carregados dados");
              }

              if (categorias == null) {
                return CircularProgressorMini();
              }

              return CircleAvatar(
                foregroundColor: Theme.of(context).accentColor,
                child: Text(
                  (subCategoriaController.subCategorias.value.length ?? 0)
                      .toString(),
                ),
              );
            },
          ),
          SizedBox(width: 5),
          CircleAvatar(
            foregroundColor: Theme.of(context).accentColor,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                subCategoriaController.getAll();
              },
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SubCategoriaList(categoria: categoria),
    );
  }
}
