import 'dart:ui';

import 'package:bofluttermobile/src/core/controller/produto_controller.dart';
import 'package:bofluttermobile/src/core/model/favorito.dart';
import 'package:bofluttermobile/src/core/model/produto.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class ProdutoDetalhesView extends StatefulWidget {
  Produto p;

  ProdutoDetalhesView(this.p);

  @override
  _ProdutoDetalhesViewState createState() => _ProdutoDetalhesViewState();
}

class _ProdutoDetalhesViewState extends State<ProdutoDetalhesView>
    with SingleTickerProviderStateMixin {
  var produtoController = GetIt.I.get<ProdutoController>();

  AnimationController animationController;
  Animation<double> animation;
  static final _scaleTween = Tween<double>(begin: 1.0, end: 1.5);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFavorito = false;

  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  Produto produto;
  Favorito favorito;

  @override
  void initState() {
    if (produto == null) {
      produto = Produto();
      favorito = Favorito();
    }
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceInOut,
    );

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    produto = widget.p;
    return buildContainer(produto);
  }

  favoritar(Favorito p) {
    if (this.isFavorito == false) {
      this.isFavorito = !this.isFavorito;
      print("Teste 1: ${this.isFavorito}");
    } else {
      this.isFavorito = !this.isFavorito;
      print("Teste 2: ${this.isFavorito}");
    }
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

  buildContainer(Produto p) {
    return ListView(
      children: <Widget>[
        Container(
          height: 350,
          width: double.infinity,
          child: p.arquivos.isNotEmpty
              ? Carousel(
                  autoplay: false,
                  dotBgColor: Colors.transparent,
                  images: p.arquivos.map((a) {
                    return NetworkImage(produtoController.arquivo + a.foto);
                  }).toList())
              : p.foto != null
                  ? Image.network(
                      produtoController.arquivo + p.foto,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey[300],
                    ),
        ),
        Container(
          child: Column(
            children: [
              Container(
                child: ListTile(
                  title: Text(
                    "Departamento",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${p.subCategoria.nome}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: p.status == true
                      ? Text(
                          "produto disponivel",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          "produto indisponivel",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text(
                    "De ${formatMoeda.format(p.estoque.valorUnitario)}",
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                      decorationStyle: TextDecorationStyle.dashed,
                    ),
                  ),
                  subtitle: Text(
                    "R\$ ${formatMoeda.format(p.estoque.valorUnitario - ((p.estoque.valorUnitario * p.promocao.desconto) / 100))} a vista",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Chip(
                    backgroundColor: Theme.of(context).accentColor,
                    label: Text(
                      "${formatMoeda.format(p.promocao.desconto)} OFF",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
