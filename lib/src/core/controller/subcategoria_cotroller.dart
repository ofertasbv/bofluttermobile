import 'package:bofluttermobile/src/api/constants/constant_api.dart';
import 'package:bofluttermobile/src/core/model/subcategoria.dart';
import 'package:bofluttermobile/src/core/repository/subcategoria_repository.dart';
import 'package:mobx/mobx.dart';

part 'subcategoria_cotroller.g.dart';

class SubcategoriaCotroller = SubcategoriaCotrollerBase
    with _$SubcategoriaCotroller;

abstract class SubcategoriaCotrollerBase with Store {
  SubCategoriaRepository subCategoriaRepository;

  SubcategoriaCotrollerBase() {
    subCategoriaRepository = SubCategoriaRepository();
  }

  @observable
  String arquivo = ConstantApi.urlArquivoSubCategoria;

  @observable
  ObservableFuture<List<SubCategoria>> subCategorias;

  @action
  getAll() {
    subCategorias = subCategoriaRepository.getAll().asObservable();
  }

  @action
  getAllByNome(String nome) {
    subCategorias = subCategoriaRepository.getAllByNome(nome).asObservable();
  }

  @action
  getAllByCategoria(int id) {
    subCategorias = subCategoriaRepository.getAllByCategoriaById(id).asObservable();
  }
}
