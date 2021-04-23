import 'package:bofluttermobile/src/page/cliente/cliente_create_page.dart';
import 'package:bofluttermobile/src/page/home/categoria_list_home.dart';
import 'package:bofluttermobile/src/page/home/produto_list_home.dart';
import 'package:bofluttermobile/src/page/home/promocao_list_home.dart';
import 'package:bofluttermobile/src/page/loja/teste_mapa.dart';
import 'package:bofluttermobile/src/page/produto/produto_page.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_page.dart';
import 'package:bofluttermobile/src/page/seguimento/seguimento_page.dart';
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
        SizedBox(height: 0),
        Column(
          children: <Widget>[
            Container(
              height: 100,
              padding: EdgeInsets.all(10),
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Theme.of(context).accentColor,
                            radius: 30,
                            child: Icon(Icons.shop, size: 30),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ClienteCreatePage();
                              },
                            ),
                          );
                        },
                      ),
                      Text("cadastre-se")
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Theme.of(context).primaryColor,
                            radius: 30,
                            child: Icon(
                              Icons.monetization_on_outlined,
                              size: 30,
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
                      ),
                      Text("vantagens")
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Theme.of(context).primaryColor,
                            radius: 30,
                            child: Icon(
                              Icons.local_offer_outlined,
                              size: 30,
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
                      ),
                      Text("ofertas")
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Theme.of(context).primaryColor,
                            radius: 30,
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return SeguimentoPage();
                              },
                            ),
                          );
                        },
                      ),
                      Text("mercardo")
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Theme.of(context).primaryColor,
                            radius: 30,
                            child: Icon(
                              Icons.location_on_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return TesteMapa();
                              },
                            ),
                          );
                        },
                      ),
                      Text("lojas"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          children: <Widget>[
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.wallet_giftcard_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Ofertas em destaque",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("As melhores ofertas com descontos especiais"),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).primaryColor,
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
              child: ListTile(
                leading: Icon(
                  Icons.shopping_cart_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Mercado online",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Produtos com ofertas especiais"),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).primaryColor,
                ),
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
