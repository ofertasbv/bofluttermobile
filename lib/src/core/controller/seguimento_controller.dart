import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/core/model/seguimento.dart';
import 'package:bofluttermobile/src/core/repository/seguimento_repository.dart';
import 'package:mobx/mobx.dart';

part 'seguimento_controller.g.dart';

class SeguimentoController = SeguimentoControllerBase
    with _$SeguimentoController;

abstract class SeguimentoControllerBase with Store {
  SeguimentoRepository seguimentoRepository;

  SeguimentoControllerBase() {
    seguimentoRepository = SeguimentoRepository();
  }

  @observable
  String arquivo = ConstantApi.urlArquivoCategoria;

  @observable
  ObservableFuture<List<Seguimento>> seguimentos;

  @action
  getAll() {
    seguimentos = seguimentoRepository.getAll().asObservable();
  }

  @action
  getAllByNome(String nome) {
    seguimentos = seguimentoRepository.getAllByNome(nome).asObservable();
  }
}
