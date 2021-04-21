import 'dart:async';

import 'package:bofluttermobile/src/core/controller/produto_controller.dart';
import 'package:bofluttermobile/src/core/filter/produto_filter.dart';
import 'package:bofluttermobile/src/core/model/produto.dart';
import 'package:bofluttermobile/src/page/produto/produto_page.dart';
import 'package:bofluttermobile/src/util/container/container_produto.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:bofluttermobile/src/util/load/shimmerListProdutoHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ProdutoListHome extends StatefulWidget {
  @override
  _ProdutoListHomeState createState() => _ProdutoListHomeState();
}

class _ProdutoListHomeState extends State<ProdutoListHome>
    with AutomaticKeepAliveClientMixin<ProdutoListHome> {
  var produtoController = GetIt.I.get<ProdutoController>();
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  @override
  void initState() {
    produtoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    produtoController.getAll();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return builderConteudoList();
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Produto> produtos = produtoController.produtos.value;
          if (produtoController.produtos.error != null) {
            return Text("Não foi possível buscar produtos");
          }

          if (produtos == null) {
            return ShimmerListProdutoHome();
          }
          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(produtos),
          );
        },
      ),
    );
  }

  builderList(List<Produto> produtos) {
    double containerWidth = 250;
    double containerHeight = 20;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto p = produtos[index];

        return GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              color: Colors.white,
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey[300].withOpacity(1),
                    padding: EdgeInsets.all(0),
                    child: p.foto != null
                        ? Container(
                            width: 150,
                            height: 150,
                            color: Colors.grey[300].withOpacity(1),
                            child: Image.network(
                              "${produtoController.arquivo + p.foto}",
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: 150,
                            height: 150,
                            color: Colors.grey[300].withOpacity(1),
                          ),
                  ),
                  Container(
                    width: 200,
                    height: 150,
                    color: Colors.white,
                    padding: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Container(
                          child: ListTile(
                            isThreeLine: false,
                            title: Text(
                              p.nome,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${p.loja.nome}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            isThreeLine: false,
                            title: Text(
                              p.promocao.nome,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            subtitle: Text(
                              "R\$ ${formatMoeda.format(p.valorComDesconto)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
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
                  return ProdutoPage();
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
