import 'package:bofluttermobile/src/core/controller/produto_controller.dart';
import 'package:bofluttermobile/src/core/filter/produto_filter.dart';
import 'package:bofluttermobile/src/core/model/produto.dart';
import 'package:bofluttermobile/src/page/produto/produto_filter_page.dart';
import 'package:bofluttermobile/src/page/produto/produto_grid.dart';
import 'package:bofluttermobile/src/page/produto/produto_list.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class ProdutoPage extends StatefulWidget {
  ProdutoFilter filter;

  ProdutoPage({Key key, this.filter}) : super(key: key);

  @override
  _ProdutoPageState createState() => _ProdutoPageState(filter: this.filter);
}

class _ProdutoPageState extends State<ProdutoPage> {
  var produtoController = GetIt.I.get<ProdutoController>();
  var nomeController = TextEditingController();

  ProdutoFilter filter;
  String pagina = "";

  _ProdutoPageState({this.filter});

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      produtoController.getAllFilter(filter);
    } else {
      nome = nomeController.text;
      produtoController.getAllByNome(nome);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        actions: [
          Observer(
            builder: (context) {
              List<Produto> produtos = produtoController.produtos.value;
              if (produtoController.produtos.error != null) {
                return CircleAvatar(child: Icon(Icons.warning_amber_outlined));
              }

              if (produtos == null) {
                return CircularProgressorMini();
              }

              return CircleAvatar(
                child: Text(
                  (produtoController.produtos.value.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor.withOpacity(1),
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.dashboard,
                color: Colors.grey[200],
              ),
              onPressed: () {
                setState(() {
                  pagina = "grid";
                });
              },
            ),
          ),
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.table_rows,
                color: Colors.grey[200],
              ),
              onPressed: () {
                setState(() {
                  pagina = "list";
                });
              },
            ),
          ),
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
                produtoController.getAllFilter(filter);
              },
            ),
          ),
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.tune,
                color: Colors.grey[200],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProdutoFilterPage();
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
      body: buildScrollbar(context),
    );
  }

  buildScrollbar(BuildContext context) {
    return Container(
      child: pagina == "grid"
          ? ProdutoGrid(filter: filter)
          : ProdutoList(filter: filter),
    );
  }
}
