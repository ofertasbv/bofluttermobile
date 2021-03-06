import 'dart:io';
import 'package:bofluttermobile/src/core/filter/produto_filter.dart';
import 'package:dio/dio.dart';
import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/api/dio/custon_dio.dart';
import 'package:bofluttermobile/src/core/model/produto.dart';
import 'package:bofluttermobile/src/core/model/produtopage.dart';
import 'package:bofluttermobile/src/core/model/produtoprincipal.dart';
import 'package:mobx/mobx.dart';

class ProdutoRepository {
  CustonDio dio = CustonDio();

  Future<ProdutoData> nextPageProduto() async {
    try {
      var response = await dio.client
          .get("/produtos/filter")
          .then((value) => ProdutoData.fromJson(value.data));
      print("resposta: ${response.produto}");
      return response;
    } on Exception catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<Produto>> getAllById(int id) async {
    try {
      print("carregando produtos by id");
      var response = await dio.client.get("/produtos/${id}");
      print("resposta: ${response}");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getAllByNome(String nome) async {
    try {
      print("carregando produtos by nome");
      var response = await dio.client.get("/produtos/nome/${nome}");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getAll() async {
    try {
      print("carregando produtos");
      var response = await dio.client.get("/produtos");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getFilter(ProdutoFilter filter) async {
    try {
      print("carregando produtos filtrados");
      var response = await dio.client.get(
        "/produtos/filter",
        queryParameters: {
          "nomeProduto": filter.nomeProduto,
          "valorMinimo": filter.valorMinimo,
          "valorMaximo": filter.valorMaximo,
          "subCategoria": filter.subCategoria,
          "loja": filter.loja,
          "marca": filter.marca,
          "promocao": filter.promocao,
        },
      );
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<ObservableList<ProdutoPrincipal>> listaTodos1() async {
    var response = await Dio().get("http://localhost:8081/produtos/filter");
    print("response pageable 1: ${response.data}");
    return (response.data as List)
        .map((c) => ProdutoPrincipal.fromJson(c))
        .toList();
  }

  Future<ObservableList<ProdutoData>> listaTodos2() async {
    var response = await dio.client.get("/produtos/filter");
    print("response pageable 2: ${response.data}");
    return (response.data).map((c) => ProdutoData.fromJson(c)).toList();
  }

  Future<ProdutoData> listaTodos3() async {
    var response = await dio.client
        .get("/produtos/filter")
        .then((v) => ProdutoData.fromJson(v.data));
    print("response pageable 3: ${response.totalElements}");
    return response;
  }

  Future<ProdutoData> findAll() async {
    var response = await dio.client
        .get('/produtos/filter')
        .then((res) => ProdutoData.fromJson(res.data))
        .catchError(print);
    print("response pageable 3: ${response.produto}");
    return response;
  }

  Future<List<Produto>> getAllBySubCategoriaById(int id) async {
    try {
      print("carregando produtos da subcategoria");
      var response = await dio.client.get("/produtos/subcategoria/$id");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getAllByLojaById(int id) async {
    try {
      print("carregando produtos da loja");
      var response = await dio.client.get("/produtos/loja/$id");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<Produto> getByCodBarra(String codigoBarra) async {
    try {
      print("carregando produtos by codigo de barra");
      var response = await dio.client.get("/produtos/codigobarra/$codigoBarra");
      return Produto.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/produtos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/produtos/update/$id", data: data);
    return response.statusCode;
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response = await dio.client.delete("/produtos/delete/foto/$foto");
      return response.statusCode;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<String> upload(File file, String fileName) async {
    var arquivo = file.path;

    var paramentros = {
      "foto": await MultipartFile.fromFile(arquivo, filename: fileName)
    };

    FormData formData = FormData.fromMap(paramentros);
    var response = await dio.client
        .post(ConstantApi.urlList + "/produtos/upload", data: formData);
    return response.toString();
  }
}
