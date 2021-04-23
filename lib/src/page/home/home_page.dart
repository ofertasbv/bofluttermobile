import 'package:bofluttermobile/main.dart';
import 'package:bofluttermobile/src/core/controller/pedidoItem_controller.dart';
import 'package:bofluttermobile/src/page/categoria/categoria_list.dart';
import 'package:bofluttermobile/src/page/home/drawer_list.dart';
import 'package:bofluttermobile/src/page/home/home.dart';
import 'package:bofluttermobile/src/page/loja/loja_list.dart';
import 'package:bofluttermobile/src/page/loja/teste_mapa.dart';
import 'package:bofluttermobile/src/page/pedidoitem/pedito_itens_page.dart';
import 'package:bofluttermobile/src/page/produto/produto_list.dart';
import 'package:bofluttermobile/src/page/produto/produto_search.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_list.dart';
import 'package:bofluttermobile/src/page/seguimento/seguimento_list.dart';
import 'package:bofluttermobile/src/page/usuario/usuario_login.dart';
import 'package:bofluttermobile/src/page/usuario/usuario_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var pageController = PageController();

  int elementIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            bottomOpacity: 0,
            titleSpacing: 0,
            title: Container(
              height: 80,
              width: 80,
              child: Container(
                height: 80,
                width: 80,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "BOOK",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.shopping_basket_outlined,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        "OFERTAS",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              CircleAvatar(
                foregroundColor: Theme.of(context).accentColor,
                child: IconButton(
                  icon: Icon(
                    Icons.location_on_outlined,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TesteMapa(
                          androidFusedLocation: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 5),
              CircleAvatar(
                foregroundColor: Theme.of(context).accentColor,
                child: IconButton(
                  icon: Icon(
                    Icons.search_outlined,
                  ),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: ProdutoSearchDelegate(),
                    );
                  },
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                child: CircleAvatar(
                  foregroundColor: Theme.of(context).accentColor,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 0, right: 0),
                        child: Icon(Icons.shopping_basket),
                      ),
                      Container(
                        child: Container(
                          margin: EdgeInsets.only(top: 0, right: 0),
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.black, width: 1),
                            color: Colors.white.withOpacity(0.7),
                          ),
                          child: Center(
                            child: Text(
                              (pedidoItemController.itens.length ?? 0)
                                  .toString(),
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PedidoItensListPage(),
                    ),
                  );
                },
              ),
              SizedBox(width: 10),
            ],
          ),
          body: Center(child: lista[elementIndex]),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text('início'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wallet_giftcard_outlined),
                title: Text('departamentos'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_convenience_store_outlined),
                title: Text('lojas'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_alert_outlined),
                title: Text('ofertas'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                title: Text('perfil'),
              ),
            ],
            currentIndex: elementIndex,
            onTap: changeIndex,
            elevation: 4,
          ),

/* ======================= Menu lateral ======================= */
          drawer: DrawerList(),
/* ======================= Botão Flutuante ======================= */
        ),
      ),
    );
  }

  buildGestureDetector(BuildContext context) {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 2, right: 2),
            child: Icon(Icons.shopping_basket),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 16),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.white.withOpacity(.7),
            ),
            child: Center(
              child: Text("0"),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Future<bool> onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Deseja sair do aplicativo?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Não'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: new Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
  }

  List lista = [
    CatalogoHome(),
    SeguimentoList(),
    LojaList(),
    PromocaoList(),
    UsuarioLogin(),
  ];

  changeIndex(int index) {
    setState(() {
      elementIndex = index;
    });
  }
}
