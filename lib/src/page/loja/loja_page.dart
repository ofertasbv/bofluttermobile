
import 'package:bofluttermobile/src/page/loja/loja_list.dart';
import 'package:flutter/material.dart';

class LojaPage extends StatefulWidget {
  @override
  _LojaPageState createState() => _LojaPageState();
}

class _LojaPageState extends State<LojaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todas as lojas"),
      ),
      body: LojaList(),
    );
  }
}
