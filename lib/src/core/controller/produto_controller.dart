import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/core/filter/produto_filter.dart';
import 'package:bofluttermobile/src/core/model/produto.dart';
import 'package:bofluttermobile/src/core/repository/produto_repository.dart';
import 'package:mobx/mobx.dart';

part 'produto_controller.g.dart';

class ProdutoController = ProdutoControllerBase with _$ProdutoController;

abstract class ProdutoControllerBase with Store {
  ProdutoRepository produtoRepository;

  ProdutoControllerBase() {
    produtoRepository = ProdutoRepository();
  }

  @observable
  String arquivo = ConstantApi.urlArquivoProduto;

  @observable
  ObservableFuture<List<Produto>> produtos;

  @action
  getAll() {
    produtos = produtoRepository.getAll().asObservable();
  }

  @action
  getAllFilter(ProdutoFilter filter) {
    produtos = produtoRepository.getFilter(filter).asObservable();
  }

  @action
  getAllByNome(String nome) {
    produtos = produtoRepository.getAllByNome(nome).asObservable();
  }
}
