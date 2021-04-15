import 'package:bofluttermobile/main.dart';
import 'package:bofluttermobile/src/page/categoria/categoria_list.dart';
import 'package:bofluttermobile/src/page/home/drawer_list.dart';
import 'package:bofluttermobile/src/page/home/home.dart';
import 'package:bofluttermobile/src/page/loja/loja_list.dart';
import 'package:bofluttermobile/src/page/produto/produto_list.dart';
import 'package:bofluttermobile/src/page/produto/produto_search.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
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
            title: Text("BOOKOFERTAS"),
            actions: <Widget>[
              CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey[200],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          // builder: (context) => TesteMapa(
                          //   androidFusedLocation: true,
                          // ),
                          ),
                    );
                  },
                ),
              ),
              SizedBox(width: 5),
              CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.grey[200],
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
                  backgroundColor: Theme.of(context).accentColor,
                  foregroundColor: Colors.black,
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
                            color: Colors.white.withOpacity(.7),
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
                        // builder: (context) => ItemPage(),
                        ),
                  );
                },
              ),
              SizedBox(width: 5),
            ],
          ),
          body: Center(child: lista[elementIndex]),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text('home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined),
                title: Text('categorias'),
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
                icon: Icon(Icons.shopping_cart_outlined),
                title: Text('produtos'),
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
    CategoriaList(),
    LojaList(),
    PromocaoList(),
    ProdutoList(),
  ];

  changeIndex(int index) {
    setState(() {
      elementIndex = index;
    });
  }
}
