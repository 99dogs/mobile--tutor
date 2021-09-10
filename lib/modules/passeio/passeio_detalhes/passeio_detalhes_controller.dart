import 'package:flutter/cupertino.dart';
import 'package:tutor/repositories/avaliacao_repository.dart';
import 'package:tutor/repositories/passeio_repository.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/avaliacao_model.dart';
import 'package:tutor/shared/models/passeio_model.dart';
import 'package:intl/intl.dart';

class PasseioDetalhesController {
  final formKey = GlobalKey<FormState>();
  final passeioRepository = PasseioRepository();
  final avaliacaoRepository = AvaliacaoRepository();
  PasseioModel passeio = PasseioModel();
  AvaliacaoModel avaliacao = AvaliacaoModel();
  AvaliacaoModel newAvaliacao = AvaliacaoModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final avaliacaoState = ValueNotifier<StateEnum>(StateEnum.start);

  void onChanged({
    double? nota,
    String? descricao,
    int? passeioId,
  }) {
    newAvaliacao = newAvaliacao.copyWith(
      nota: nota,
      descricao: descricao,
      passeioId: passeio.id,
    );
  }

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
      avaliacao = await avaliacaoRepository.buscarPorId(passeioId);

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

  Future<String?> avaliar() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        avaliacaoState.value = StateEnum.loading;
        String? response = await avaliacaoRepository.cadastrar(newAvaliacao);
        avaliacaoState.value = StateEnum.success;
        return response;
      } catch (e) {
        avaliacaoState.value = StateEnum.error;
        return e.toString();
      }
    }
  }
}
