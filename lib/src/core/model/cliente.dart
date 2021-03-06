import 'package:bofluttermobile/src/core/model/endereco.dart';
import 'package:bofluttermobile/src/core/model/pessoa.dart';
import 'package:bofluttermobile/src/core/model/usuario.dart';

class Cliente extends Pessoa{
  int id;
  String nome;
  String telefone;
  String tipoPessoa;
  String foto;
  Usuario usuario = new Usuario();
  String cpf;
  String sexo;
  List<Endereco> enderecos;

  Cliente({
    this.id,
    this.nome,
    this.telefone,
    this.tipoPessoa,
    this.foto,
    this.usuario,
    this.cpf,
    this.sexo,
    this.enderecos,
  });

  Cliente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    telefone = json['telefone'];
    tipoPessoa = json['tipoPessoa'];
    foto = json['foto'];
    usuario =
        json['usuario'] != null ? new Usuario.fromJson(json['usuario']) : null;

    if (json['enderecos'] != null) {
      enderecos = new List<Endereco>();
      json['enderecos'].forEach((v) {
        enderecos.add(new Endereco.fromJson(v));
      });
    }

    cpf = json['cpf'];
    sexo = json['sexo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['telefone'] = this.telefone;
    data['tipoPessoa'] = this.tipoPessoa;
    data['foto'] = this.foto;
    if (this.usuario != null) {
      data['usuario'] = this.usuario.toJson();
    }

    data['cpf'] = this.cpf;
    data['sexo'] = this.sexo;

    if (this.enderecos != null) {
      data['enderecos'] = this.enderecos.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
