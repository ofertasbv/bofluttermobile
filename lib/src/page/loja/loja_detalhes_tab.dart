import 'package:bofluttermobile/src/core/controller/loja_controller.dart';
import 'package:bofluttermobile/src/core/filter/produto_filter.dart';
import 'package:bofluttermobile/src/core/model/loja.dart';
import 'package:bofluttermobile/src/page/loja/loja_detalhes-view.dart';
import 'package:bofluttermobile/src/page/loja/loja_detalhes_info.dart';
import 'package:bofluttermobile/src/page/produto/produto_page.dart';
import 'package:bofluttermobile/src/page/produto/produto_search.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LojaDetalhesTab extends StatefulWidget {
  Loja p;

  LojaDetalhesTab(this.p);

  @override
  _LojaDetalhesTabState createState() => _LojaDetalhesTabState();
}

class _LojaDetalhesTabState extends State<LojaDetalhesTab>
    with SingleTickerProviderStateMixin {
  var lojaController = GetIt.I.get<LojaController>();
  Loja loja;
  ProdutoFilter produtoFilter = ProdutoFilter();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showDefaultSnackbar(BuildContext context, String content) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    loja = widget.p;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Text(loja.nome),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              foregroundColor: Colors.white,
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
          ],
          bottom: TabBar(
            indicatorPadding: EdgeInsets.only(right: 6, left: 6),
            labelPadding: EdgeInsets.only(right: 6, left: 6),
            tabs: <Widget>[
              Tab(
                child: Text("VISÃO GERAL"),
              ),
              Tab(
                child: Text("INFORMAÇÕES"),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 0, right: 0, top: 0),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              LojaDetalhesView(loja),
              LojaDetalhesInfo(loja),
            ],
          ),
        ),
        bottomNavigationBar: buildBottomNavigationBar(context, loja),
      ),
    );
  }

  buildBottomNavigationBar(BuildContext context, Loja loja) {
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
                        return PromocaoPage();
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
                  produtoFilter.loja = loja.id;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProdutoPage(filter: produtoFilter);
                      },
                    ),
                  );
                },
                label: Text(
                  "VER PRODUTOS".toUpperCase(),
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
