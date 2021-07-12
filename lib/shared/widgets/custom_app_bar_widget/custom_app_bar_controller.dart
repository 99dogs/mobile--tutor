import 'package:tutor/shared/auth/auth_controller.dart';
import 'package:tutor/shared/models/usuario_logado_model.dart';

class CustomAppBarController {
  final authController = AuthController();

  UsuarioLogadoModel _usuario = UsuarioLogadoModel();

  UsuarioLogadoModel getUsuario() {
    _usuario = authController.obterSessao() as UsuarioLogadoModel;
    return _usuario;
  }
}
