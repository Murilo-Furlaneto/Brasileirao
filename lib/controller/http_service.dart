import 'dart:convert';
import 'package:brasileirao/controller/api_service.dart';
import 'package:brasileirao/key.dart';
import 'package:brasileirao/model/artilheiro_model.dart';
import 'package:brasileirao/model/tabela_model.dart';
import 'package:http/http.dart' as http;

class HttpService implements ApiService {
  static const String _baseUrl = 'https://api.api-futebol.com.br/v1';
  static const String _accessToken = 'Bearer $TOKEN';

  @override
  Future<List<Tabela>> fetchCampeonato() async {
    final url = Uri.parse('$_baseUrl/campeonatos/10/tabela');
    final headers = {'Authorization': _accessToken};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((item) => Tabela.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao fazer requisição: ${response.statusCode}');
    }
  }

  @override
  Future<List<Artilheiro>> fetchArtilharia() async {
    final url = Uri.parse('$_baseUrl/campeonatos/10/artilharia');
    final headers = {'Authorization': _accessToken};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((item) => Artilheiro.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao fazer requisição: ${response.statusCode}');
    }
  }
}
