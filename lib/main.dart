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
import 'package:bofluttermobile/src/page/usuario/usuario_login_page.dart';
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
      statusBarColor: Colors.transparent,
      // cor da barra superior
      statusBarIconBrightness: Brightness.light,
      // ícones da barra superior
      systemNavigationBarColor: Colors.grey[100],
      // cor da barra inferior
      systemNavigationBarIconBrightness: Brightness.dark,
      //
      systemNavigationBarDividerColor: Colors.transparent,
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
      home: HomePage(),
    );
  }
}
