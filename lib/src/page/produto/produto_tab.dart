import 'package:bofluttermobile/src/core/controller/pedidoItem_controller.dart';
import 'package:bofluttermobile/src/core/controller/produto_controller.dart';
import 'package:bofluttermobile/src/core/model/pedidoitem.dart';
import 'package:bofluttermobile/src/core/model/produto.dart';
import 'package:bofluttermobile/src/page/pedidoitem/pedito_itens_page.dart';
import 'package:bofluttermobile/src/page/produto/prduto_view.dart';
import 'package:bofluttermobile/src/page/produto/produto_info.dart';
import 'package:bofluttermobile/src/page/produto/produto_page.dart';
import 'package:bofluttermobile/src/page/produto/produto_search.dart';
import 'package:bofluttermobile/src/util/snackbar/snackbar_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProdutoDetalhesTab extends StatefulWidget {
  Produto p;

  ProdutoDetalhesTab(this.p);

  @override
  _ProdutoDetalhesTabState createState() => _ProdutoDetalhesTabState();
}

class _ProdutoDetalhesTabState extends State<ProdutoDetalhesTab>
    with SingleTickerProviderStateMixin {
  var produtoController = GetIt.I.get<ProdutoController>();
  var pedidoItemController = GetIt.I.get<PedidoItemController>();

  AnimationController animationController;
  Animation<double> animation;
  static final scaleTween = Tween<double>(begin: 1.0, end: 1.5);

  bool isFavorito = false;

  Produto p;
  var text = "";

  @override
  void initState() {
    if (p == null) {
      p = Produto();
    }
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceInOut,
    );

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  showSnackbar(BuildContext context, String texto) {
    final snackbar = SnackBar(content: Text(texto));
    GlobalScaffold.instance.showSnackbar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    p = widget.p;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: GlobalScaffold.instance.scaffkey,
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          title: p.nome == null ? Text("Detalhes do produto") : Text(p.nome),
          actions: <Widget>[
            CircleAvatar(
              foregroundColor: Theme.of(context).accentColor,
              child: IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ProdutoSearchDelegate(),
                  );
                },
              ),
            ),
            SizedBox(width: 10),
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
                            (pedidoItemController.itens.length ?? 0).toString(),
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
            SizedBox(width: 5),
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.grey[200],
                constraints: BoxConstraints.expand(height: 50),
                child: TabBar(tabs: [
                  Tab(
                    child: Text(
                      "VISÃO GERAL",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "INFORMAÇÕES",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      ProdutoDetalhesView(p),
                      ProdutoDetalhesInfo(p),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: buildBottomNavigationBar(context),
      ),
    );
  }

  buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      color: Colors.grey[100],
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: FlatButton.icon(
                icon: Icon(Icons.list_alt),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: Colors.transparent),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProdutoPage();
                      },
                    ),
                  );
                },
                label: Text(
                  "VER MAIS".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: FlatButton.icon(
                icon: Icon(Icons.shopping_basket),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: Colors.transparent),
                ),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  if (pedidoItemController
                      .isExisteItem(new PedidoItem(produto: p))) {
                    showSnackbar(context, "${p.nome} já existe");
                  } else {
                    showSnackbar(context, "${p.nome} adicionado");
                    setState(() {
                      pedidoItemController
                          .adicionar(new PedidoItem(produto: p));
                      animationController.forward();
                    });
                  }
                },
                label: Text(
                  "LISTA DE DESEJO".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
