import 'package:bofluttermobile/src/core/model/caixafluxo.dart';

class CaixaFluxoSaida {
  int id;
  String descricao;
  double valorSaida;
  DateTime dataRegistro;
  CaixaFluxo caixaFluxo;

  CaixaFluxoSaida({
    this.id,
    this.descricao,
    this.valorSaida,
    this.dataRegistro,
    this.caixaFluxo,
  });

  CaixaFluxoSaida.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    valorSaida = json['valorSaida'];
    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());

    caixaFluxo = json['caixaFluxo'] != null
        ? new CaixaFluxo.fromJson(json['caixaFluxo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['valorSaida'] = this.valorSaida;
    data['dataRegistro'] = this.dataRegistro.toIso8601String();

    if (this.caixaFluxo != null) {
      data['caixaFluxo'] = this.caixaFluxo.toJson();
    }
    return data;
  }
}
