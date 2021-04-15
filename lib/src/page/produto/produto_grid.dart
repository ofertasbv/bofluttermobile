import 'dart:ui';
import 'package:bofluttermobile/src/core/controller/produto_controller.dart';
import 'package:bofluttermobile/src/core/filter/produto_filter.dart';
import 'package:bofluttermobile/src/core/model/produto.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ProdutoGrid extends StatefulWidget {
  ProdutoFilter filter;

  ProdutoGrid({Key key, this.filter}) : super(key: key);

  @override
  _ProdutoGridState createState() => _ProdutoGridState(filter: this.filter);
}

class _ProdutoGridState extends State<ProdutoGrid>
    with AutomaticKeepAliveClientMixin<ProdutoGrid> {
  _ProdutoGridState({this.filter});

  var produtoController = GetIt.I.get<ProdutoController>();

  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  final scaffoldKey = GlobalKey<ScaffoldState>();

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

  showSnackbar(BuildContext context, String content) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(bottom: 0),
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
            child: builderGrid(produtos),
          );
        },
      ),
    );
  }

  builderGrid(List<Produto> produtos) {
    return Container(
      padding: EdgeInsets.only(top: 0, bottom: 0),
      child: Container(
        child: GridView.builder(
          padding: EdgeInsets.only(top: 0, bottom: 20, left: 0, right: 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: MediaQuery.of(context).size.aspectRatio * 0.9,
          ),
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            Produto p = produtos[index];
            return GestureDetector(
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(0),
                ),
                duration: Duration(seconds: 2),
                curve: Curves.bounceIn,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        p.foto != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Image.network(
                                  produtoController.arquivo + p.foto,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              )
                            : Container(
                                height: 200,
                                color: Colors.grey,
                              ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, right: 10),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.redAccent,
                              radius: 15,
                              child: IconButton(
                                splashColor: Colors.black,
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.redAccent,
                                  size: 15,
                                ),
                                onPressed: () {
                                  setState(() {
                                    print("Favoritar: ${p.nome}");
                                    // favoritar();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 50,
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
                          height: 70,
                          child: ListTile(
                            title: Text(
                              "R\$ ${formatMoeda.format(p.estoque.valorUnitario)}",
                              style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                decorationStyle: TextDecorationStyle.dashed,
                              ),
                            ),
                            subtitle: Text(
                              "R\$ ${formatMoeda.format(p.estoque.valorUnitario - ((p.estoque.valorUnitario * p.promocao.desconto) / 100))}",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          child: ListTile(
                            leading: Chip(
                              backgroundColor: Theme.of(context).accentColor,
                              label: Text(
                                "${formatMoeda.format(p.promocao.desconto)} OFF",
                                style: TextStyle(
                                  color: Colors.grey[100],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      // return ProdutoDetalhesTab(p);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
