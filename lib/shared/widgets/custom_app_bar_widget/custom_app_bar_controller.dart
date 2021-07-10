import 'package:tutor/modules/login/login_controller.dart';
import 'package:tutor/shared/models/usuario_logado_model.dart';

class CustomAppBarController {
  final loginController = LoginController();

  UsuarioLogadoModel _usuario = UsuarioLogadoModel();

  UsuarioLogadoModel getUsuario() {
    _usuario = loginController.obterSessao() as UsuarioLogadoModel;
    return _usuario;
  }
}
