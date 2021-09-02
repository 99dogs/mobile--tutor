import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tutor/shared/auth/auth_controller.dart';
import 'package:tutor/shared/models/passeio_lat_long_model.dart';
import 'package:tutor/shared/models/passeio_model.dart';
import 'package:tutor/shared/models/response_data_model.dart';
import 'package:tutor/shared/models/solicitar_passeio_model.dart';
import 'package:tutor/shared/models/usuario_logado_model.dart';

class PasseioRepository {
  final _endpointApi = dotenv.get('ENDPOINT_API', fallback: '');
  final _authController = AuthController();
  var _client = http.Client();
  String _token = "";

  Future<Map<String, String>> headers() async {
    var headers = Map<String, String>();
    UsuarioLogadoModel usuario = await _authController.obterSessao();

    if (usuario.token != null && usuario.token!.isNotEmpty) {
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

  Future<List<PasseioModel>> buscarTodos() async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/passeio",
      );
      var response = await _client.get(url, headers: await this.headers());

      if (response.statusCode == 200) {
        List<PasseioModel> cachorros = (jsonDecode(response.body) as List)
            .map((data) => PasseioModel.fromJson(data))
            .toList();

        return cachorros;
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<PasseioModel> buscarPorId(int id) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/passeio/" + id.toString(),
      );

      var response = await _client.get(
        url,
        headers: await this.headers(),
      );

      PasseioModel passeio = PasseioModel.fromJson(
        jsonDecode(response.body),
      );

      if (response.statusCode == 200) {
        return passeio;
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<PasseioModel> solicitar(SolicitarPasseioModel solicitacao) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/passeio",
      );

      var response = await _client.post(
        url,
        headers: await this.headers(),
        body: jsonEncode(solicitacao),
      );

      if (response.statusCode == 200) {
        PasseioModel passeio = PasseioModel.fromJson(
          jsonDecode(response.body),
        );

        return passeio;
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<PasseioLatLongModel> posicaoAtual(int id) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/passeio/localizacao/posicao-atual/$id",
      );

      var response = await _client.get(
        url,
        headers: await this.headers(),
      );

      if (response.statusCode == 200) {
        PasseioLatLongModel latLong = PasseioLatLongModel.fromJson(
          jsonDecode(response.body),
        );

        return latLong;
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<List<PasseioLatLongModel>> posicaoCompleta(int id) async {
    try {
      var url = Uri.parse(
        _endpointApi + "/api/v1/passeio/localizacao/posicao-completa/$id",
      );
      var response = await _client.get(url, headers: await this.headers());

      if (response.statusCode == 200) {
        List<PasseioLatLongModel> localizacoes =
            (jsonDecode(response.body) as List)
                .map((data) => PasseioLatLongModel.fromJson(data))
                .toList();

        return localizacoes;
      } else if (response.statusCode == 402 || response.statusCode == 502) {
        throw ("Ocorreu um problema inesperado.");
      } else {
        ResponseDataModel responseData =
            ResponseDataModel.fromJson(response.body);

        throw (responseData.mensagem);
      }
    } catch (e) {
      throw (e);
    }
  }
}
