import 'package:brasileirao/service/http_service.dart';
import 'package:brasileirao/repository/api_repository.dart';
import 'package:brasileirao/model/artilheiro_model.dart';
import 'package:brasileirao/model/tabela_model.dart';

class ApiRepositoryImpl {
  final HttpService apiService;

  ApiRepositoryImpl(this.apiService);

  Future<List<Artilheiro>> fetchArtilharia() async {
    try {
      return apiService.fetchArtilharia();
    } catch (e) {
      throw Exception('Erro ao buscar os artilheiros');
    }
  }

  Future<List<Tabela>> fetchCampeonato() async {
    try {
      return apiService.fetchCampeonato();
    } catch (e) {
      throw Exception('Erro ao buscar a tabela de classificação');
    }
  }
}
