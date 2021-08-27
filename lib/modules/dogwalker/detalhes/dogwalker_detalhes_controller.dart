import 'package:flutter/cupertino.dart';
import 'package:tutor/repositories/configuracao_horario_repository.dart';
import 'package:tutor/repositories/qualificacao_repository.dart';
import 'package:tutor/repositories/usuario_repository.dart';
import 'package:tutor/shared/auth/auth_controller.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/configuracao_horario_model.dart';
import 'package:tutor/shared/models/qualificacao_model.dart';
import 'package:tutor/shared/models/usuario_logado_model.dart';
import 'package:tutor/shared/models/usuario_model.dart';
import 'package:intl/intl.dart';

class DogwalkerDetalhesController {
  final authController = AuthController();
  final usuarioRepository = UsuarioRepository();
  final configuracaoHorarioRepository = ConfiguracaoHorarioRepository();
  final qualificacaoRepository = QualificacaoRepository();

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  UsuarioModel dogwalker = UsuarioModel();
  UsuarioModel tutor = UsuarioModel();
  UsuarioLogadoModel usuarioLogado = UsuarioLogadoModel();
  List<ConfiguracaoHorarioModel> horarios = [];
  List<QualificacaoModel> qualificacoes = [];

  formataData(
    _date,
  ) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate).toString();
  }

  Future init(int id) async {
    try {
      errorException.value = "";
      state.value = StateEnum.loading;
      usuarioLogado = await authController.obterSessao();
      tutor = await usuarioRepository.buscarPorId(usuarioLogado.id!);
      dogwalker = await usuarioRepository.buscarPorId(id);
      horarios = await configuracaoHorarioRepository.buscarPorDogwalker(id);
      qualificacoes = await qualificacaoRepository.buscarPorDogwalker(id);
      state.value = StateEnum.success;
    } catch (e) {
      state.value = StateEnum.error;
      errorException.value = e.toString();
    }
  }
}
