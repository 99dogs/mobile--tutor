import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor/modules/meus_tickets/detalhes_ticket_controller.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/item_detail_list/item_detail_list_widget.dart';
import 'package:tutor/shared/widgets/shimmer_input/shimmer_input_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalhesTicketPage extends StatefulWidget {
  final int id;
  const DetalhesTicketPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _DetalhesTicketPageState createState() => _DetalhesTicketPageState();
}

class _DetalhesTicketPageState extends State<DetalhesTicketPage> {
  final controller = DetalhesTicketController();
  String statusPagamento = "";

  @override
  void initState() {
    start();
    super.initState();
  }

  void start() async {
    await controller.init(widget.id);
    if (controller.ticket.pendente!) {
      statusPagamento = "Pendente";
    } else if (controller.ticket.cancelado!) {
      statusPagamento = "Cancelado";
    } else if (controller.ticket.pago!) {
      statusPagamento = "Pago";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: AppColors.background,
          height: size.height,
          child: Column(
            children: [
              Container(
                height: 80,
                color: AppColors.primary,
              ),
              Container(
                color: AppColors.background,
                child: Column(
                  children: [
                    TitlePageWidget(
                      title: "Detalhes do ticket",
                      enableBackButton: true,
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: controller.state,
                builder: (_, value, __) {
                  StateEnum state = value as StateEnum;
                  if (state == StateEnum.loading) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ShimmerInputWidget();
                          },
                        ),
                      ),
                    );
                  } else if (state == StateEnum.success) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.7,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: AppColors.shape,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                ItemDetailWidget(
                                  icon: FontAwesomeIcons.hashtag,
                                  label: "Identificação do ticket",
                                  info: controller.ticket.faturaId!,
                                ),
                                ItemDetailWidget(
                                  icon: FontAwesomeIcons.calendarDay,
                                  label: "Solicitado dia",
                                  info: controller.formataDataHora(
                                      controller.ticket.criado!),
                                ),
                                ItemDetailWidget(
                                  icon: FontAwesomeIcons.calendarTimes,
                                  label: "Vencimento para",
                                  info: controller
                                      .formataData(controller.ticket.criado!),
                                ),
                                ItemDetailWidget(
                                  icon: FontAwesomeIcons.tag,
                                  label: "Forma de pagamento",
                                  info:
                                      controller.ticket.formaDePagamento!.nome!,
                                ),
                                ItemDetailWidget(
                                  icon: FontAwesomeIcons.flagCheckered,
                                  label: "Status",
                                  info: statusPagamento,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          String _url =
                                              controller.ticket.faturaUrl!;
                                          await canLaunch(_url)
                                              ? await launch(_url)
                                              : throw 'Could not launch $_url';
                                        },
                                        icon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.link,
                                            size: 15,
                                          ),
                                        ),
                                        label: Text("Acessar fatura"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Ocorreu um problema inesperado.",
                              style: TextStyles.input,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                controller.init(widget.id);
                              },
                              icon: Icon(Icons.refresh_outlined),
                              label: Text("Tentar novamente"),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
