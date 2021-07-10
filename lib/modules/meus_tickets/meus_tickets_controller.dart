import 'package:flutter/cupertino.dart';
import 'package:tutor/repositories/ticket_repository.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/ticket_model.dart';
import 'package:intl/intl.dart';

class MeusTicketsController {
  final _ticketRepository = TicketRepository();
  List<TicketModel> tickets = [];

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  getFormatedDate(_date) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy\nHH:mm');
    return outputFormat.format(inputDate).toString();
  }

  Future buscarTodos() async {
    try {
      errorException.value = "";
      state.value = StateEnum.loading;
      tickets = await _ticketRepository.buscarTodos();
      state.value = StateEnum.success;
    } catch (e) {
      errorException.value = e.toString();
      state.value = StateEnum.error;
    }
  }
}
