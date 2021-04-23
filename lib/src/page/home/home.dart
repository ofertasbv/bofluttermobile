import 'package:bofluttermobile/src/page/cliente/cliente_create_page.dart';
import 'package:bofluttermobile/src/page/home/categoria_list_home.dart';
import 'package:bofluttermobile/src/page/home/club_vantagens_home.dart';
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
              height: 110,
              padding: EdgeInsets.all(10),
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.green[200],
                            foregroundColor: Colors.grey[100],
                            radius: 30,
                            child: Icon(
                              Icons.shop,
                              size: 40,
                            ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.purple[200],
                            foregroundColor: Colors.grey[100],
                            radius: 30,
                            child: Icon(
                              Icons.monetization_on_outlined,
                              size: 40,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.blue[200],
                            foregroundColor: Colors.grey[100],
                            radius: 30,
                            child: Icon(
                              Icons.local_offer_outlined,
                              size: 40,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.deepOrange[200],
                            foregroundColor: Colors.grey[100],
                            radius: 30,
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 40,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Colors.deepPurple[200],
                            foregroundColor: Colors.grey[100],
                            radius: 30,
                            child: Icon(
                              Icons.location_on_outlined,
                              size: 40,
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
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 300,
          padding: EdgeInsets.all(2),
          child: PromocaoListHome(),
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
                  "Club de vantagens",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Ganhe desconto a cada compra realizada"),
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
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          padding: EdgeInsets.all(2),
          child: ClubVantagensHome(),
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
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 156,
          padding: EdgeInsets.all(2),
          child: ProdutoListHome(),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
