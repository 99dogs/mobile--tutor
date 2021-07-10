import 'package:flutter/cupertino.dart';
import 'package:tutor/repositories/cachorro_repository.dart';
import 'package:tutor/shared/models/cachorro_model.dart';

class MeusCaesController {
  final cachorroRepository = CachorroRepository();
  List<CachorroModel> cachorros = [];

  final state = ValueNotifier<MeusCaesState>(MeusCaesState.start);
  final errorException = ValueNotifier<String>("");

  Future buscarTodos() async {
    try {
      state.value = MeusCaesState.loading;
      cachorros = await cachorroRepository.buscarTodos();
      state.value = MeusCaesState.success;
    } catch (e) {
      state.value = MeusCaesState.error;
      errorException.value = e.toString();
    }
  }
}

enum MeusCaesState { start, loading, success, error }
