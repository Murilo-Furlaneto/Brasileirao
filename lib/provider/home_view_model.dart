import 'package:flutter/material.dart';
import 'package:brasileirao/model/artilheiro_model.dart';
import 'package:brasileirao/model/tabela_model.dart';
import 'package:brasileirao/repository/api_repository_impl.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiRepositoryImpl apiRepository;

  HomeViewModel(this.apiRepository);

  List<Tabela>? tabela;
  List<Artilheiro>? artilheiros;
  String? errorMessage;

  Future<void> initializeData() async {
    try {
      final tabelaData = await apiRepository.fetchCampeonato();
      final artilheirosData = await apiRepository.fetchArtilharia();

      tabela = tabelaData;
      artilheiros = artilheirosData;
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Erro ao buscar dados: $e';
    }
    notifyListeners();
  }
}
