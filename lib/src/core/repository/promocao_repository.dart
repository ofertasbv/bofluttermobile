import 'dart:io';

import 'package:bofluttermobile/src/core/filter/promocao_filter.dart';
import 'package:dio/dio.dart';
import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/api/dio/custon_dio.dart';
import 'package:bofluttermobile/src/core/model/promocao.dart';

class PromocaoRepository {
  CustonDio dio = CustonDio();

  Future<List<Promocao>> getAll() async {
    try {
      print("carregando promoções");
      var response = await dio.client.get("/promocoes");
      return (response.data as List).map((c) => Promocao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Promocao>> getAllById(int id) async {
    try {
      print("carregando promoções by id");
      var response = await dio.client.get("/promocoes/${id}");
      return (response.data as List).map((c) => Promocao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Promocao>> getFilter(PromocaoFilter filter) async {
    try {
      print("carregando promocoes filtrados");
      var response = await dio.client.get(
        "/promocoes/filter",
        queryParameters: {
          "nomePromocao": filter.nomePromocao,
          "status": filter.status,
          "dataInicio": filter.dataInicio,
          "dataFinal": filter.dataFinal,
          "promocaoTipo": filter.promocaoTipo,
          "loja": filter.loja,
        },
      );
      return (response.data as List).map((c) => Promocao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Promocao>> getAllByNome(String nome) async {
    try {
      print("carregando promoções by nome");
      var response = await dio.client.get("/promocoes/nome/${nome}");
      return (response.data as List).map((c) => Promocao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Promocao>> getAllByStatus(bool status) async {
    try {
      print("carregando promoções by status");
      var response = await dio.client.get("/promocoes/status/${status}");
      return (response.data as List).map((c) => Promocao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Promocao>> getAllByLojaById(int id) async {
    try {
      print("carregando promocoes da loja");
      var response = await dio.client.get("/promocoes/loja/$id");
      return (response.data as List).map((c) => Promocao.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    var response = await dio.client.post("/promocoes/create", data: data);
    return response.statusCode;
  }

  Future<int> update(int id, Map<String, dynamic> data) async {
    var response = await dio.client.put("/promocoes/update/$id", data: data);
    return response.statusCode;
  }

  Future<void> deleteFoto(String foto) async {
    try {
      var response = await dio.client.delete("/promocoes/delete/foto/$foto");
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
        .post(ConstantApi.urlList + "/promocoes/upload", data: formData);
    return response.toString();
  }
}
