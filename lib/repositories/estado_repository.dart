import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor/shared/auth/auth_controller.dart';
import 'package:tutor/shared/constants/endpoint_api.dart';
import 'package:tutor/shared/models/estado_model.dart';
import 'package:tutor/shared/models/usuario_logado_model.dart';

class EstadoRepository {
  final _endpointApi = EndpointApi();
  final _authController = AuthController();
  var _client = http.Client();
  String _token = "";

  Future<Map<String, String>> headers() async {
    var headers = Map<String, String>();
    UsuarioLogadoModel usuario = await _authController.obterSessao();

    if (_token.isEmpty) {
      _token = usuario.token!;
    }

    if (_token.isEmpty) {
      headers = {"Content-Type": "application/json; charset=utf-8"};
    } else {
      headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Bearer " + _token,
      };
    }

    return headers;
  }

  Future<List<EstadoModel>> buscarTodos() async {
    try {
      var url = Uri.parse(_endpointApi.urlApi + "/api/v1/estado");
      var response = await _client.get(url, headers: await this.headers());

      List<EstadoModel> estados = (jsonDecode(response.body) as List)
          .map((data) => EstadoModel.fromJson(data))
          .toList();

      return estados;
    } catch (e) {
      throw Exception(e);
    }
  }
}
