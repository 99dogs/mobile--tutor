import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor/shared/auth/auth_controller.dart';
import 'package:tutor/shared/constants/endpoint_api.dart';
import 'package:tutor/shared/models/response_data_model.dart';
import 'package:tutor/shared/models/ticket_fatura_model.dart';
import 'package:tutor/shared/models/ticket_model.dart';
import 'package:tutor/shared/models/usuario_logado_model.dart';

class TicketRepository {
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

  Future<List<TicketModel>> buscarTodos() async {
    try {
      var url = Uri.parse(
        _endpointApi.urlApi + "/api/v1/ticket",
      );
      var response = await _client.get(url, headers: await this.headers());

      if (response.statusCode == 200) {
        List<TicketModel> tickets = (jsonDecode(response.body) as List)
            .map((data) => TicketModel.fromJson(data))
            .toList();

        return tickets;
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

  Future<TicketModel> solicitar(TicketModel ticket) async {
    try {
      var url = Uri.parse(
        _endpointApi.urlApi + "/api/v1/ticket",
      );

      Map<String, dynamic> body = {
        "quantidade": ticket.quantidade,
        "unitario": ticket.unitario,
        "total": ticket.total,
        "formaDePagamentoId": ticket.formaDePagamentoId,
      };

      var response = await _client.post(
        url,
        headers: await this.headers(),
        body: jsonEncode(body),
      );

      TicketModel novoTicket = TicketModel.fromJson(
        jsonDecode(response.body),
      );

      if (response.statusCode == 200) {
        return novoTicket;
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

  Future<String?> faturar(TicketFaturaModel ticketFatura) async {
    try {
      ticketFatura.cpfPagador =
          ticketFatura.cpfPagador!.replaceAll(".", "").replaceAll("-", "");
      var url = Uri.parse(
        _endpointApi.urlApi + "/api/v1/ticket/faturar",
      );
      var response = await _client.post(
        url,
        headers: await this.headers(),
        body: jsonEncode(ticketFatura),
      );

      if (response.statusCode == 200) {
        return "";
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
