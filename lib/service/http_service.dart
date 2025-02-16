import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:brasileirao/repository/api_repository.dart';
import 'package:brasileirao/core/constants/api_contants.dart';
import 'package:brasileirao/core/errors/request_exceptions.dart';
import 'package:brasileirao/model/artilheiro_model.dart';
import 'package:brasileirao/model/tabela_model.dart';
import 'package:http/http.dart' as http;

class HttpService implements ApiRepository {
  final String _baseUrl = ApiContants.url;
  final String _accessToken = ApiContants.token;
  final Duration _timeOut = const Duration(seconds: 10);

  @override
  Future<List<Tabela>> fetchCampeonato() async {
    final url = Uri.parse('$_baseUrl/campeonatos/10/tabela');
    final headers = {'Authorization': 'Bearer $_accessToken'};
    try {
      final response = await http.get(url, headers: headers).timeout(_timeOut);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((item) => Tabela.fromJson(item)).toList();
      } else {
        throw Exception(
            'Erro ao fazer requisição: ${response.statusCode}. Detalhes: ${response.body}');
      }
    } on SocketException {
      throw RequestExceptions(
          "Erro de coneexão: Verifique sua conexão com a internet.");
    } on TimeoutException {
      throw RequestExceptions(
          "tempo limite de requisição excecido. Verifique sua conexão ou tente novamente");
    } on Exception catch (e) {
      throw RequestExceptions("Erro inesperado: $e");
    }
  }

  @override
  Future<List<Artilheiro>> fetchArtilharia() async {
    final url = Uri.parse('$_baseUrl/campeonatos/10/artilharia');
    final headers = {'Authorization': _accessToken};
    try {
      final response = await http.get(url, headers: headers).timeout(_timeOut);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((item) => Artilheiro.fromJson(item)).toList();
      } else {
        throw Exception(
            'Erro ao fazer requisição: ${response.statusCode}. Detalhes: ${response.body}');
      }
    } on SocketException {
      throw RequestExceptions("Erro de conexão: Verifique sua internet.");
    } on TimeoutException {
      throw RequestExceptions(
          'Tempo limite da requisição excedido. Verifique sua conexão ou tente novamente mais tarde.');
    } on Exception catch (e) {
      throw RequestExceptions('Erro inesperado: $e');
    }
  }
}
