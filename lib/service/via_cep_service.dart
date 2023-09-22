// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:app/model/resul_cep.dart';

class ViaCepService {
  var client = Client;

  Future<ResultCep> fetchCep({required String cep}) async {
    final response = await client.get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 200) {
      return ResultCep.fromJson(response.body);
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}
