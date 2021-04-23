import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/core/controller/promocao_controller.dart';
import 'package:bofluttermobile/src/core/filter/produto_filter.dart';
import 'package:bofluttermobile/src/core/model/promocao.dart';
import 'package:bofluttermobile/src/page/produto/produto_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContainerPromocao extends StatelessWidget {
  PromocaoController promocaoController;
  Promocao p;

  ContainerPromocao(this.promocaoController, this.p);

  ProdutoFilter filter = ProdutoFilter();

  @override
  Widget build(BuildContext context) {
    var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");
    var dateFormat = DateFormat('dd/MM/yyyy');

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1),
        child: Container(
          color: Colors.white,
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.transparent,
                padding: EdgeInsets.all(0),
                child: p.foto != null
                    ? Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: Image.network(
                          "${promocaoController.arquivo + p.foto}",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                      ),
              ),
              Container(
                width: 180,
                height: 100,
                color: Colors.transparent,
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
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
                width: 80,
                height: 100,
                color: Colors.transparent,
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Chip(
                      backgroundColor: Theme.of(context).accentColor,
                      label: Text(
                        "OFF",
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                    ),
                    Text(
                      "${formatMoeda.format(p.desconto)} %",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        filter.promocao = p.id;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdutoPage(filter: filter),
          ),
        );
      },
    );
  }
}
