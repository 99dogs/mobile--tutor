import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor/modules/login/login_controller.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/usuario_login_model.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/input_text/input_text_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  UsuarioLogin usuarioLogin = UsuarioLogin();

  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: size.height * 0.2,
              child: Container(
                height: size.height * 0.62,
                width: size.width - 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.background,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "99Dogs",
                            style: TextStyles.titleLogo,
                          ),
                          Text(
                            "Melhor lugar para encontrar dogwalkers.",
                            style: TextStyles.captionBoldBody,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 40,
                      ),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            InputTextWidget(
                              label: "Digite seu e-mail.",
                              icon: Icons.email_outlined,
                              controller: _controllerEmail,
                              validator: controller.validarEmail,
                              onChanged: (value) {
                                controller.onChange(email: value);
                              },
                            ),
                            InputTextWidget(
                              label: "Digite sua senha.",
                              icon: Icons.lock_outline,
                              obscureText: true,
                              controller: _controllerSenha,
                              validator: controller.validarSenha,
                              onChanged: (value) {
                                controller.onChange(senha: value);
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: controller.errorException,
                              builder: (_, value, __) {
                                String error = value as String;
                                if (error.isNotEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      child: Text(
                                        error,
                                        style: TextStyles.textError,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: controller.state,
                              builder: (
                                context,
                                value,
                                child,
                              ) {
                                StateEnum state = value as StateEnum;
                                if (state == StateEnum.loading) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return ElevatedButton(
                                    onPressed: () {
                                      controller.autenticar(context);
                                    },
                                    child: Text("Entrar"),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              "/signin",
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.heading,
                          ),
                          icon: Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: 14,
                          ),
                          label: Text("Retornar"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
