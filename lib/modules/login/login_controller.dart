import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor/repositories/usuario_repository.dart';
import 'package:tutor/shared/auth/auth_controller.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/usuario_logado_model.dart';
import 'package:tutor/shared/models/usuario_login_model.dart';

class LoginController {
  final _usuarioRepository = UsuarioRepository();
  final formKey = GlobalKey<FormState>();
  final authController = AuthController();

  UsuarioLogin model = UsuarioLogin();

  final state = ValueNotifier<StateEnum>(StateEnum.start);
  final errorException = ValueNotifier<String>("");

  void onChange({
    String? email,
    String? senha,
  }) {
    model = model.copyWith(
      email: email,
      senha: senha,
    );
  }

  String? validarEmail(String? value) =>
      value?.isEmpty ?? true ? "O campo e-mail não poder vazio." : null;

  String? validarSenha(String? value) =>
      value?.isEmpty ?? true ? "O campo senha não pode ser vazio." : null;

  void autenticar(BuildContext context) async {
    final form = formKey.currentState;

    if (form!.validate()) {
      try {
        errorException.value = "";
        state.value = StateEnum.loading;
        UsuarioLogadoModel usuario = await _usuarioRepository.login(model);
        await authController.salvarSessao(usuario);
        state.value = StateEnum.success;
        Navigator.pushReplacementNamed(context, "/home");
      } catch (e) {
        state.value = StateEnum.error;
        errorException.value = e.toString();
        throw (e);
      }
    }
  }

  void validarSessao(BuildContext context) async {
    UsuarioLogadoModel usuario = UsuarioLogadoModel();
    usuario = await authController.obterSessao();
    await _delay();

    try {
      if (usuario.token!.isNotEmpty) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    } catch (e) {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  void encerrarSessao(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey("usuario")) {
      await instance.setString("usuario", "");
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> _delay() async {
    await Future.delayed(Duration(seconds: 3));
  }
}
