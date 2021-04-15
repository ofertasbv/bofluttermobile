import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/core/model/loja.dart';
import 'package:bofluttermobile/src/core/repository/loja_repository.dart';
import 'package:mobx/mobx.dart';

part 'loja_controller.g.dart';

class LojaController = LojaControllerBase with _$LojaController;

abstract class LojaControllerBase with Store {
  LojaRepository lojaRepository;

  LojaControllerBase() {
    lojaRepository = LojaRepository();
  }

  @observable
  String arquivo = ConstantApi.urlArquivoLoja;

  @observable
  ObservableFuture<List<Loja>> lojas;

  @action
  getAll() {
    lojas = lojaRepository.getAll().asObservable();
  }

  @action
  getAllByNome(String nome) {
    lojas = lojaRepository.getAllByNome(nome).asObservable();
  }
}
