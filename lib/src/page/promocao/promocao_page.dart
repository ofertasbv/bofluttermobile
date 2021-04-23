import 'package:bofluttermobile/src/core/controller/promocao_controller.dart';
import 'package:bofluttermobile/src/core/model/promocao.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_list.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class PromocaoPage extends StatefulWidget {
  @override
  _PromocaoPageState createState() => _PromocaoPageState();
}

class _PromocaoPageState extends State<PromocaoPage> {
  var promocaoController = GetIt.I.get<PromocaoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todas as promoções"),
        elevation: 0,
        actions: [
          Observer(
            builder: (context) {
              List<Promocao> promocoes = promocaoController.promocoes.value;
              if (promocaoController.promocoes.error != null) {
                return Text("Não foi possível carregados dados");
              }

              if (promocoes == null) {
                return CircularProgressorMini();
              }

              return CircleAvatar(
                foregroundColor: Theme.of(context).accentColor,
                child: Text(
                  (promocaoController.promocoes.value.length ?? 0)
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
                promocaoController.getAll();
              },
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child: PromocaoList(),
      ),
    );
  }
}
