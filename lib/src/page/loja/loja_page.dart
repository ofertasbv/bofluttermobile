import 'package:bofluttermobile/src/core/controller/loja_controller.dart';
import 'package:bofluttermobile/src/core/model/loja.dart';
import 'package:bofluttermobile/src/page/loja/loja_list.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class LojaPage extends StatefulWidget {
  @override
  _LojaPageState createState() => _LojaPageState();
}

class _LojaPageState extends State<LojaPage> {
  var lojaController = GetIt.I.get<LojaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todas as lojas"),
        elevation: 0,
        actions: [
          Observer(
            builder: (context) {
              List<Loja> lojas = lojaController.lojas.value;
              if (lojaController.lojas.error != null) {
                return Text("Não foi possível carregados dados");
              }

              if (lojas == null) {
                return CircularProgressorMini();
              }

              return CircleAvatar(
                foregroundColor: Theme.of(context).accentColor,
                child: Text(
                  (lojaController.lojas.value.length ?? 0).toString(),
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
                lojaController.getAll();
              },
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: LojaList(),
      ),
    );
  }
}
