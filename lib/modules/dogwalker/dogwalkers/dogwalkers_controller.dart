import 'package:flutter/cupertino.dart';
import 'package:tutor/repositories/usuario_repository.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/usuario_model.dart';

class DogwalkersController {
  final _usuarioRepository = UsuarioRepository();
  List<UsuarioModel> dogwalkers = [];

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  Future buscarTodos() async {
    try {
      errorException.value = "";
      state.value = StateEnum.loading;
      dogwalkers = await _usuarioRepository.buscarDogwalkers();
      state.value = StateEnum.success;
    } catch (e) {
      errorException.value = e.toString();
      state.value = StateEnum.error;
    }
  }
}
