import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor/shared/models/usuario_logado_model.dart';

class AuthController {
  Future<UsuarioLogadoModel> obterSessao() async {
    UsuarioLogadoModel usuario = UsuarioLogadoModel();
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey("usuario")) {
      final json = instance.get("usuario") as String;
      if (json.isNotEmpty) {
        usuario = UsuarioLogadoModel.fromJson(json);
      }
    }
    return usuario;
  }
}
