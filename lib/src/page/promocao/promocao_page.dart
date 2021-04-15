import 'package:bofluttermobile/src/core/controller/promocao_controller.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_list.dart';
import 'package:flutter/material.dart';
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
        actions: [
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
                promocaoController.getAll();
              },
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child: PromocaoList(),
      ),
    );
  }
}
