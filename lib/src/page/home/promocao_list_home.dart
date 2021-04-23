import 'dart:async';

import 'package:bofluttermobile/src/core/controller/promocao_controller.dart';
import 'package:bofluttermobile/src/core/model/loja.dart';
import 'package:bofluttermobile/src/core/model/promocao.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_page.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:bofluttermobile/src/util/load/shimmerListPromocaoHome.dart';
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
            return ShimmerListPromocaoHome();
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
            child: Container(
              height: 300,
              width: containerWidth,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  buildAnimatedContainer(containerWidth, p, context),
                  buildContainerText(containerWidth, p, context),
                ],
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

  buildAnimatedContainer(
      double containerWidth, Promocao p, BuildContext context) {
    return AnimatedContainer(
      width: containerWidth,
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: p.foto != null
                ? Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        promocaoController.arquivo + p.foto,
                        fit: BoxFit.fill,
                        width: containerWidth,
                        height: 295,
                      ),
                    ),
                  )
                : Container(
                    width: containerWidth,
                    height: 290,
                    child: Icon(
                      Icons.photo,
                      size: 110,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                  ),
          ),
          SizedBox(height: 0),
        ],
      ),
    );
  }

  buildContainerText(double containerWidth, Promocao p, BuildContext context) {
    return Positioned(
      bottom: 10,
      child: Container(
        width: containerWidth,
        child: ListTile(
          title: Text(
            p.nome,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
