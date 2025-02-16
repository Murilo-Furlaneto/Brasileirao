import 'package:brasileirao/model/artilheiro_model.dart';
import 'package:brasileirao/model/tabela_model.dart';

abstract class ApiRepository {
  Future<List<Tabela>> fetchCampeonato();
  Future<List<Artilheiro>> fetchArtilharia();
}
