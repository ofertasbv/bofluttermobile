import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/core/model/categoria.dart';
import 'package:bofluttermobile/src/core/repository/categoria_repository.dart';
import 'package:mobx/mobx.dart';

part 'categoria_controller.g.dart';

class CategoriaController = CategoriaControllerBase with _$CategoriaController;

abstract class CategoriaControllerBase with Store {
  CategoriaRepository categoriaRepository;

  CategoriaControllerBase() {
    categoriaRepository = CategoriaRepository();
  }

  @observable
  String arquivo = ConstantApi.urlArquivoCategoria;

  @observable
  ObservableFuture<List<Categoria>> categorias;

  @action
  getAll() {
    categorias = categoriaRepository.getAll().asObservable();
  }

  @action
  getAllByNome(String nome) {
    categorias = categoriaRepository.getAllByNome(nome).asObservable();
  }

  @action
  getAllBySeguimento(int id) {
    categorias = categoriaRepository.getAllBySeguimento(id).asObservable();
  }
}
