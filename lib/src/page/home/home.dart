import 'package:bofluttermobile/src/page/home/categoria_list_home.dart';
import 'package:bofluttermobile/src/page/home/produto_list_produto.dart';
import 'package:bofluttermobile/src/page/home/promocao_list_home.dart';
import 'package:bofluttermobile/src/page/produto/produto_page.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatalogoHome extends StatefulWidget {
  @override
  _CatalogoHomeState createState() => _CatalogoHomeState();
}

class _CatalogoHomeState extends State<CatalogoHome> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        SizedBox(height: 5),
        Column(
          children: <Widget>[
            Container(
              height: 150,
              padding: EdgeInsets.all(0),
              child: CategoriaListHome(),
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Ofertas em destaque"),
                  GestureDetector(
                    child: Text("veja mais"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return PromocaoPage();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 300,
              padding: EdgeInsets.all(2),
              child: PromocaoListHome(),
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Prouduto em destaque"),
                  GestureDetector(
                    child: Text("veja mais"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProdutoPage();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 156,
              padding: EdgeInsets.all(0),
              child: ProdutoListHome(),
            ),
          ],
        ),
      ],
    );
  }
}
