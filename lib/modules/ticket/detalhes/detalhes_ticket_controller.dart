import 'package:flutter/cupertino.dart';
import 'package:tutor/repositories/ticket_repository.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/ticket_model.dart';
import 'package:intl/intl.dart';

class DetalhesTicketController {
  final ticketRepository = TicketRepository();
  TicketModel ticket = TicketModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  formataData(
    _date,
  ) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate).toString();
  }

  formataDataHora(
    _date,
  ) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
    return outputFormat.format(inputDate).toString();
  }

  Future init(int id) async {
    try {
      errorException.value = "";
      state.value = StateEnum.loading;
      ticket = await ticketRepository.buscarPorId(id);
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
      errorException.value = e.toString();
    }
  }
}
