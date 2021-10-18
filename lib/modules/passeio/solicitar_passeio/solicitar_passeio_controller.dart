import 'package:flutter/cupertino.dart';
import 'package:tutor/repositories/cachorro_repository.dart';
import 'package:tutor/repositories/horario_repository.dart';
import 'package:tutor/repositories/passeio_repository.dart';
import 'package:tutor/repositories/usuario_repository.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/cachorro_model.dart';
import 'package:tutor/shared/models/disponibilidade_model.dart';
import 'package:tutor/shared/models/passeio_model.dart';
import 'package:tutor/shared/models/solicitar_passeio_model.dart';
import 'package:tutor/shared/models/usuario_model.dart';
import 'package:intl/intl.dart';

class SolicitarPasseioController {
  final formKey = GlobalKey<FormState>();

  final usuarioRepository = UsuarioRepository();
  final cachorroRepository = CachorroRepository();
  final horarioRepository = HorarioRepository();
  final passeioRepository = PasseioRepository();

  UsuarioModel dogwalker = UsuarioModel();
  List<CachorroModel> cachorros = [];
  PasseioModel passeio = PasseioModel();
  SolicitarPasseioModel solicitarPasseio = SolicitarPasseioModel();

  final state = ValueNotifier<StateEnum>(StateEnum.start);

  formataDataHora(
    _date,
  ) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return outputFormat.format(inputDate).toString();
  }

  List<dynamic> _listCachorros = [];
  int cachorroId = 0;
  String? datahora;

  int get getCachorroId {
    return cachorroId;
  }

  void set setCachorroId(int value) {
    cachorroId = value;
    _listCachorros.clear();
    _listCachorros.add(value);
  }

  String get getDatahora {
    return datahora ?? "";
  }

  void set setDataHora(DateTime? value) {
    datahora = value.toString();
  }

  Future init(int dogwalkerId) async {
    try {
      state.value = StateEnum.loading;
      dogwalker = await usuarioRepository.buscarPorId(dogwalkerId);
      cachorros = await cachorroRepository.buscarTodos();

      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
    }
  }

  Future<bool> verificarDisponibilidade(DateTime? datahoraSolicitada) async {
    try {
      String datahora = formataDataHora(datahoraSolicitada.toString());
      DisponibilidadeModel disponibilidade = DisponibilidadeModel(
        datahora: datahora,
        usuarioId: dogwalker.id!,
      );

      bool disponivel =
          await horarioRepository.verificarDisponibilidade(disponibilidade);
      return disponivel;
    } catch (e) {
      return false;
    }
  }

  Future<PasseioModel?> solicitar() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        state.value = StateEnum.loading;

        solicitarPasseio = solicitarPasseio.copyWith(
          datahora: formataDataHora(datahora),
          dogwalkerId: dogwalker.id!,
          cachorrosIds: _listCachorros,
        );

        PasseioModel novoPasseio = PasseioModel();
        novoPasseio = await passeioRepository.solicitar(solicitarPasseio);

        if (novoPasseio.id == null) {
          throw ("Ocorreu um problema ao solicitar o passeio");
        }

        state.value = StateEnum.success;

        return novoPasseio;
      } catch (e) {
        state.value = StateEnum.success;
        throw (e.toString());
      }
    }
  }
}
