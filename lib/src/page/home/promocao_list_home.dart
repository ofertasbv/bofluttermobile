import 'dart:async';

import 'package:bofluttermobile/src/core/controller/promocao_controller.dart';
import 'package:bofluttermobile/src/core/model/loja.dart';
import 'package:bofluttermobile/src/core/model/promocao.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_page.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class PromocaoListHome extends StatefulWidget {
  Loja p;

  PromocaoListHome({Key key, this.p}) : super(key: key);

  @override
  _PromocaoListHomeState createState() => _PromocaoListHomeState(p: this.p);
}

class _PromocaoListHomeState extends State<PromocaoListHome>
    with AutomaticKeepAliveClientMixin<PromocaoListHome> {
  var promocaoController = GetIt.I.get<PromocaoController>();
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  Loja p;

  _PromocaoListHomeState({this.p});

  @override
  void initState() {
    promocaoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return promocaoController.getAll();
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
          List<Promocao> promocoes = promocaoController.promocoes.value;
          if (promocaoController.promocoes.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (promocoes == null) {
            return CircularProgressorMini();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(promocoes),
          );
        },
      ),
    );
  }

  ListView builderList(List<Promocao> promocoes) {
    double containerWidth = 350;
    double containerHeight = 50;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: promocoes.length,
      itemBuilder: (context, index) {
        Promocao p = promocoes[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(0),
                side: BorderSide(color: Colors.grey[100], width: 1),
              ),
              child: AnimatedContainer(
                width: containerWidth,
                duration: Duration(seconds: 1),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: p.foto != null
                          ? Container(
                              child: Image.network(
                                promocaoController.arquivo + p.foto,
                                fit: BoxFit.cover,
                                width: containerWidth,
                                height: 200,
                              ),
                            )
                          : Container(
                              color: Colors.grey[300],
                              width: containerWidth,
                              height: 200,
                            ),
                    ),
                    SizedBox(height: 0),
                    Container(
                      width: containerWidth,
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text(p.nome),
                        subtitle: Text(p.descricao),
                        trailing: Chip(
                          backgroundColor: Theme.of(context).accentColor,
                          label: Text(
                            "OFF ${formatMoeda.format(p.desconto)}",
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
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoPage();
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
