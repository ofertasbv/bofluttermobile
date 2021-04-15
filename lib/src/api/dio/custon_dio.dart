

import 'package:dio/dio.dart';
import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/api/interceptors/interceptions.dart';

class CustonDio {
  Dio client = Dio();

  CustonDio() {
    client.options.baseUrl = ConstantApi.urlList;

    client.interceptors.add(CustonInterceptions());
    client.options.connectTimeout = 5000;

  }
}
