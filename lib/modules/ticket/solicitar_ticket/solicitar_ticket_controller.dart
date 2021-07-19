import 'package:flutter/cupertino.dart';
import 'package:tutor/repositories/forma_de_pagamento_repository.dart';
import 'package:tutor/repositories/ticket_repository.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/forma_de_pagamento_model.dart';
import 'package:tutor/shared/models/ticket_fatura_model.dart';
import 'package:tutor/shared/models/ticket_model.dart';

class SolicitarTicketController {
  final formKey = GlobalKey<FormState>();
  final formaDePagamentoRepository = FormaDepagamentoRepository();
  final ticketRepository = TicketRepository();
  List<FormaDePagamentoModel> formasPagamento = [];
  TicketModel ticket = TicketModel();
  TicketModel novoTicket = TicketModel();
  TicketFaturaModel ticketFatura = TicketFaturaModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final stateSolicitacao = ValueNotifier<StateEnum>(StateEnum.start);
  final erroException = ValueNotifier<String>("");

  void onChange({
    int? quantidade,
    double? unitario,
    double? total,
    int? formaDePagamentoId,
    String? cpfPagador,
  }) {
    ticket = ticket.copyWith(
      quantidade: quantidade,
      unitario: 15.0,
      total: 15.0,
      formaDePagamentoId: formaDePagamentoId,
      cpfPagador: cpfPagador,
    );
  }

  Future init() async {
    try {
      state.value = StateEnum.loading;
      formasPagamento = await formaDePagamentoRepository.buscarTodos();
      state.value = StateEnum.success;
    } catch (e) {
      erroException.value = e.toString();
      state.value = StateEnum.error;
    }
  }

  Future<String?> solicitar() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        stateSolicitacao.value = StateEnum.loading;
        novoTicket = await ticketRepository.solicitar(ticket);
        ticketFatura.ticketId = novoTicket.id;
        ticketFatura.cpfPagador = ticket.cpfPagador;
        await ticketRepository.faturar(ticketFatura);
        stateSolicitacao.value = StateEnum.success;
        return "";
      } catch (e) {
        stateSolicitacao.value = StateEnum.error;
        return e.toString();
      }
    }
  }
}
