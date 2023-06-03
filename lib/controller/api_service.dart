import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api.api-futebol.com.br/v1';
  static const String _accessToken =
      'Bearer test_b14723493b5350278f42bb854a809b';

  Future<List<dynamic>> fetchCampeonato() async {
    final url = Uri.parse('$_baseUrl/campeonatos/10/tabela');
    final headers = {'Authorization': _accessToken};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw 'Erro ao fazer requisição: ${response.statusCode}';
    }
  }

  Future<List<dynamic>> getArtilharia() async {
    final url = Uri.parse('$_baseUrl/campeonatos/10/artilharia');
    final headers = {'Authorization': _accessToken};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw 'Erro ao fazer requisição: ${response.statusCode}';
    }
  }
}
