import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor/modules/ticket/meus_tickets/meus_tickets_controller.dart';
import 'package:tutor/repositories/usuario_repository.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/usuario_model.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';

class MeuSaldoTileWidget extends StatefulWidget {
  const MeuSaldoTileWidget({Key? key}) : super(key: key);

  @override
  _MeuSaldoTileWidgetState createState() => _MeuSaldoTileWidgetState();
}

class _MeuSaldoTileWidgetState extends State<MeuSaldoTileWidget> {
  final controller = MeusTicketsController();
  final usuarioRepository = UsuarioRepository();

  UsuarioModel usuario = UsuarioModel();
  int qtdeTicketDisponivel = 0;

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    controller.state.value = StateEnum.loading;
    usuario = await usuarioRepository.buscarMinhasInformacoes();
    qtdeTicketDisponivel = usuario.qtdeTicketDisponivel!;
    controller.state.value = StateEnum.success;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (_, value, __) {
          StateEnum state = value as StateEnum;
          if (state == StateEnum.success) {
            return AnimatedCard(
              direction: AnimatedCardDirection.top,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 75),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          FontAwesomeIcons.receipt,
                          color: Colors.white,
                        ),
                        Container(
                          width: 1,
                          height: 32,
                          color: AppColors.background,
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Você possui ",
                            style: TextStyles.captionBackground,
                            children: [
                              TextSpan(
                                text: "$qtdeTicketDisponivel tickets\n",
                                style: TextStyles.captionBoldBackground,
                              ),
                              TextSpan(
                                text: "disponíveis.",
                                style: TextStyles.captionBackground,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
