import 'dart:async';

import 'package:bofluttermobile/src/core/controller/categoria_controller.dart';
import 'package:bofluttermobile/src/core/controller/cliente_controller.dart';
import 'package:bofluttermobile/src/core/controller/loja_controller.dart';
import 'package:bofluttermobile/src/core/controller/pedidoItem_controller.dart';
import 'package:bofluttermobile/src/core/controller/pedido_controller.dart';
import 'package:bofluttermobile/src/core/controller/promocao_controller.dart';
import 'package:bofluttermobile/src/core/controller/seguimento_controller.dart';
import 'package:bofluttermobile/src/core/controller/subcategoria_cotroller.dart';
import 'package:bofluttermobile/src/core/controller/usuario_controller.dart';
import 'package:bofluttermobile/src/page/home/home_page.dart';
import 'package:bofluttermobile/src/util/themes/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bofluttermobile/src/core/controller/produto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<SeguimentoController>(SeguimentoController());
  getIt.registerSingleton<CategoriaController>(CategoriaController());
  getIt.registerSingleton<SubcategoriaCotroller>(SubcategoriaCotroller());
  getIt.registerSingleton<ProdutoController>(ProdutoController());
  getIt.registerSingleton<LojaController>(LojaController());
  getIt.registerSingleton<PromocaoController>(PromocaoController());
  getIt.registerSingleton<PedidoItemController>(PedidoItemController());
  getIt.registerSingleton<PedidoController>(PedidoController());
  getIt.registerSingleton<UsuarioController>(UsuarioController());
  getIt.registerSingleton<ClienteController>(ClienteController());

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurpleAccent,
      // cor da barra superior
      statusBarIconBrightness: Brightness.dark,
      // ícones da barra superior
      systemNavigationBarColor: Colors.grey[100],
      // cor da barra inferior
      systemNavigationBarIconBrightness: Brightness.dark,
      //
      systemNavigationBarDividerColor: Colors.white,
      // ícones da barra inferior
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getTheme(context),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) {
            return HomePage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            child: buildContainer(context),
          ),
          SizedBox(height: 10),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      ),
    );
  }

  buildContainer(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Container(
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
                              fontSize: 45,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.shopping_basket_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        "OFERTAS",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text("versão 1.0"),
                    subtitle: Text("todos os direitos reservados"),
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text("contato"),
                    subtitle: Text("bookofertasbr@gmail.com"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
