import 'package:bofluttermobile/src/core/controller/produto_controller.dart';
import 'package:bofluttermobile/src/core/filter/produto_filter.dart';
import 'package:bofluttermobile/src/core/model/produto.dart';
import 'package:bofluttermobile/src/page/produto/produto_tab.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ProdutoList extends StatefulWidget {
  ProdutoFilter filter;

  ProdutoList({Key key, this.filter}) : super(key: key);

  @override
  _ProdutoListState createState() => _ProdutoListState(filter: filter);
}

class _ProdutoListState extends State<ProdutoList>
    with AutomaticKeepAliveClientMixin<ProdutoList> {
  _ProdutoListState({this.filter});

  var produtoController = GetIt.I.get<ProdutoController>();

  ProdutoFilter filter;

  @override
  void initState() {
    if (filter == null) {
      produtoController.getAll();
    } else {
      produtoController.getAllFilter(filter);
    }
    super.initState();
  }

  Future<void> onRefresh() {
    produtoController.getAllFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 0),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: builderConteudoList(),
            ),
          ),
        ],
      ),
    );
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Produto> produtos = produtoController.produtos.value;
          if (produtoController.produtos.error != null) {
            return Center(child: Text("Não foi possível buscar produtos"));
          }

          if (produtos == null) {
            return CircularProgressorMini();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderListProduto(produtos),
          );
        },
      ),
    );
  }

  builderListProduto(List<Produto> produtos) {
    var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");
    double containerWidth = 250;
    double containerHeight = 20;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto p = produtos[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Container(
              color: Colors.grey[200],
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    padding: EdgeInsets.all(0),
                    child: p.foto != null
                        ? Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: Image.network(
                              "${produtoController.arquivo + p.foto}",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                          ),
                  ),
                  Container(
                    width: 170,
                    height: 100,
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    child: ListTile(
                      title: Text(
                        p.nome,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${p.loja.nome}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 100,
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(2),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Chip(
                          backgroundColor: Theme.of(context).accentColor,
                          label: Text(
                            "R\$ ${formatMoeda.format(p.estoque.valorVenda)}",
                            style: TextStyle(
                              color: Colors.grey[100],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                              decorationStyle: TextDecorationStyle.dashed,
                            ),
                          ),
                        ),
                        Text(
                          "R\$ ${formatMoeda.format(p.valorComDesconto)}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoDetalhesTab(p);
                },
              ),
            );
          },
        );

      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
