import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/core/model/promocao.dart';
import 'package:bofluttermobile/src/core/repository/promocao_repository.dart';
import 'package:mobx/mobx.dart';

part 'promocao_controller.g.dart';

class PromocaoController = PromocaoControllerBase with _$PromocaoController;

abstract class PromocaoControllerBase with Store {
  PromocaoRepository promocaoRepository;

  PromocaoControllerBase() {
    promocaoRepository = PromocaoRepository();
  }

  @observable
  String arquivo = ConstantApi.urlArquivoPromocao;

  @observable
  ObservableFuture<List<Promocao>> promocoes;

  @action
  getAll() {
    promocoes = promocaoRepository.getAll().asObservable();
  }

  @action
  getAllByNome(String nome) {
    promocoes = promocaoRepository.getAllByNome(nome).asObservable();
  }
}
