import 'package:bofluttermobile/src/page/categoria/categoria_page.dart';
import 'package:bofluttermobile/src/page/loja/loja_page.dart';
import 'package:bofluttermobile/src/page/produto/produto_search.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_page.dart';
import 'package:bofluttermobile/src/page/sobre/sobre_page.dart';
import 'package:bofluttermobile/src/page/usuario/usuario_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: Stack(
        children: <Widget>[
          builderBodyBack(),
          menuLateral(context),
        ],
      ),
    );
  }

  builderBodyBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[100].withOpacity(0.2),
            Colors.grey[200].withOpacity(0.9)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  menuLateral(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          color: Theme.of(context).primaryColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                foregroundColor: Theme.of(context).accentColor,
                child: Icon(
                  Icons.account_circle,
                  size: 35,
                ),
                maxRadius: 20,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(0),
                  height: 55,
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text(
                      "BOOKOFERTAS",
                      style: TextStyle(
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.supervisor_account),
          title: Text("Minha conta"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return UsuarioLoginPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.search_outlined),
          title: Text("Buscar"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            showSearch(
              context: context,
              delegate: ProdutoSearchDelegate(),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.list_alt_outlined),
          title: Text("Departamentos"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoriaPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.shop_two),
          title: Text("Promoções"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.local_convenience_store_outlined),
          title: Text("Lojas"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LojaPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.info_outline),
          title: Text("Sobre"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SobrePage();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
