import 'package:flutter/cupertino.dart';
import 'package:tutor/repositories/passeio_repository.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/passeio_model.dart';
import 'package:intl/intl.dart';

class PasseioDetalhesController {
  PasseioRepository passeioRepository = PasseioRepository();
  PasseioModel passeio = PasseioModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);

  String cachorros = "";

  formatarData(_date) {
    if (_date == null) return "";
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
    return outputFormat.format(inputDate).toString();
  }

  Future init(int passeioId) async {
    try {
      state.value = StateEnum.loading;
      passeio = await passeioRepository.buscarPorId(passeioId);

      if (cachorros == "") {
        if (passeio.cachorros != null && passeio.cachorros!.length > 0) {
          passeio.cachorros!.forEach((element) {
            cachorros = cachorros + element.nome! + ",";
          });
          cachorros = cachorros.substring(0, cachorros.length - 1);
        }
      }

      state.value = StateEnum.success;
    } catch (e) {
      print(e);
      state.value = StateEnum.error;
    }
  }
}
