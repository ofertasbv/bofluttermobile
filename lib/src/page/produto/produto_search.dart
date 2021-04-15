import 'package:bofluttermobile/src/core/controller/categoria_controller.dart';
import 'package:bofluttermobile/src/core/controller/produto_controller.dart';
import 'package:bofluttermobile/src/core/filter/produto_filter.dart';
import 'package:bofluttermobile/src/core/model/produto.dart';
import 'package:bofluttermobile/src/page/produto/produto_page.dart';
import 'package:bofluttermobile/src/util/load/circular_progresso_mini.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class ProdutoSearchDelegate extends SearchDelegate<Produto> {
  var produtoController = GetIt.I.get<ProdutoController>();
  var categoriaController = GetIt.I.get<CategoriaController>();

  ProdutoFilter filter = ProdutoFilter();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
      autofocus: true,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    produtoController.getAllFilter(filter);
    return Observer(
      builder: (context) {
        List<Produto> produtos = produtoController.produtos.value;

        if (produtoController.produtos.error != null) {
          return Text("Não foi possível buscar produtos");
        }

        if (produtos == null) {
          return CircularProgressorMini();
        }

        final resultados = query.isEmpty
            ? []
            : produtos
                .where(
                    (p) => p.nome.toLowerCase().startsWith(query.toLowerCase()))
                .toList();

        return ListView.builder(
          itemBuilder: (context, index) {
            Produto p = resultados[index];
            return ListTile(
              isThreeLine: false,
              leading: p.foto != null
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "${produtoController.arquivo + p.foto}",
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey[400],
                      radius: 20,
                    ),
              title: RichText(
                text: TextSpan(
                    text: p.nome.substring(0, query.length),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: p.nome.substring(query.length),
                          style: TextStyle(color: Colors.grey))
                    ]),
              ),
              onTap: () {
                filter.nomeProduto = p.nome.substring(0, 5);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProdutoPage(filter: filter);
                    },
                  ),
                );
              },
            );
          },
          itemCount: resultados.length,
        );
      },
    );
  }
}
