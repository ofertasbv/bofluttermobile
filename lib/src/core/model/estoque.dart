

class Estoque {
  int id;
  int quantidade;
  double valorUnitario;
  double valorVenda;
  double percentual;
  String estoqueStatus;
  DateTime dataRegistro;
  DateTime dataFabricacao;
  DateTime dataVencimento;

  Estoque({
    this.id,
    this.quantidade,
    this.valorUnitario,
    this.percentual,
    this.valorVenda,
    this.estoqueStatus,
    this.dataRegistro,
    this.dataFabricacao,
    this.dataVencimento,
  });

  Estoque.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantidade = json['quantidade'];
    valorUnitario = json['valorUnitario'];
    valorVenda = json['valorVenda'];
    percentual = json['percentual'];
    estoqueStatus = json['estoqueStatus'];
    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());
    dataFabricacao = DateTime.tryParse(json['dataFabricacao'].toString());
    dataVencimento = DateTime.tryParse(json['dataVencimento'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantidade'] = this.quantidade;
    data['valorUnitario'] = this.valorUnitario;
    data['valorVenda'] = this.valorVenda;
    data['percentual'] = this.percentual;
    data['estoqueStatus'] = this.estoqueStatus;
    data['dataRegistro'] = this.dataRegistro.toIso8601String();
    data['dataFabricacao'] = this.dataFabricacao.toIso8601String();
    data['dataVencimento'] = this.dataVencimento.toIso8601String();
    return data;
  }
}
