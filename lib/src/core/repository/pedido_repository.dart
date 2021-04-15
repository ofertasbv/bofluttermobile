import 'package:bofluttermobile/src/core/filter/pedido_filter.dart';
import 'package:dio/dio.dart';
import 'package:bofluttermobile/src/api/dio/custon_dio.dart';
import 'package:bofluttermobile/src/core/model/pedido.dart';

class PedidoRepository {
  CustonDio dio = CustonDio();

  Future<List<Pedido>> getAllById(int id) async {
    try {
      print("carregando pedidos by id");
      var response = await dio.client.get("/pedidos/${id}");
      return (response.data as List).map((c) => Pedido.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Pedido>> getAll() async {
    try {
      print("carregando pedidos");
      var response = await dio.client.get("/pedidos");
      return (response.data as List).map((c) => Pedido.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Pedido>> getFilter(PedidoFilter filter) async {
    try {
      print("carregando pedidos filtrados");
      var response = await dio.client.get(
        "/pedidos/filter",
        queryParameters: {
          "descricao": filter.descricao,
          "dataRegistro": filter.dataRegistro,
          "dataEntrega": filter.dataEntrega,
          "cliente": filter.cliente,
          "loja": filter.loja,
          "status": filter.status,
          "pedidoStatus": filter.pedidoStatus,
        },
      );
      return (response.data as List).map((c) => Pedido.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/pedidos/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/pedidos/update/$id", data: data);
    return response.statusCode;
  }
}
