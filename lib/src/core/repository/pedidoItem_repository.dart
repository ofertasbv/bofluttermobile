import 'dart:io';

import 'package:bofluttermobile/src/core/filter/pedidoitem_filter.dart';
import 'package:dio/dio.dart';
import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/api/dio/custon_dio.dart';
import 'package:bofluttermobile/src/core/model/pedidoitem.dart';

class PedidoItemRepository {
  CustonDio dio = CustonDio();

  Future<List<PedidoItem>> getAllById(int id) async {
    try {
      print("carregando pedidoitens by id");
      var response = await dio.client.get("/pedidositens/${id}");
      return (response.data as List)
          .map((c) => PedidoItem.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<PedidoItem>> getAll() async {
    try {
      print("carregando pedidoitens");
      var response = await dio.client.get("/pedidositens");
      return (response.data as List)
          .map((c) => PedidoItem.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<PedidoItem>> getFilter(PedidoItemFilter filter) async {
    try {
      print("carregando pedidoItens filtrados");
      var response = await dio.client.get(
        "/pedidositens/filter",
        queryParameters: {
          "nome": filter.nome,
          "pedido": filter.pedido,
        },
      );
      return (response.data as List)
          .map((c) => PedidoItem.fromJson(c))
          .toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/pedidositens/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/pedidositens/update/$id", data: data);
    return response.statusCode;
  }
}
