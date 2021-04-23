import 'package:bofluttermobile/src/core/controller/categoria_controller.dart';
import 'package:bofluttermobile/src/core/controller/seguimento_controller.dart';
import 'package:bofluttermobile/src/core/model/seguimento.dart';
import 'package:bofluttermobile/src/page/categoria/categoria_list.dart';
import 'package:bofluttermobile/src/page/seguimento/seguimento_list.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class SeguimentoPage extends StatefulWidget {
  @override
  _SeguimentoPageState createState() => _SeguimentoPageState();
}

class _SeguimentoPageState extends State<SeguimentoPage> {
  var seguimentoController = GetIt.I.get<SeguimentoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todos os seguimentos"),
        elevation: 0,
        actions: [
          Observer(
            builder: (context) {
              List<Seguimento> seguimentos =
                  seguimentoController.seguimentos.value;
              if (seguimentoController.seguimentos.error != null) {
                return Text("Não foi possível carregados dados");
              }

              if (seguimentos == null) {
                return CircularProgressorMini();
              }

              return CircleAvatar(
                foregroundColor: Theme.of(context).accentColor,
                child: Text(
                  (seguimentoController.seguimentos.value.length ?? 0)
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
                seguimentoController.getAll();
              },
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SeguimentoList(),
    );
  }
}
