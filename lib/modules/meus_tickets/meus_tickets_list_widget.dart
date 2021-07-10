import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_tickets/meus_tickets_controller.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/shimmer_list_tile/shimmer_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class MeusTicketsListWidget extends StatefulWidget {
  const MeusTicketsListWidget({Key? key}) : super(key: key);

  @override
  _MeusTicketsListWidgetState createState() => _MeusTicketsListWidgetState();
}

class _MeusTicketsListWidgetState extends State<MeusTicketsListWidget> {
  final controller = MeusTicketsController();
  final formatCurrency = NumberFormat.currency(locale: "pt_BR");

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (_, value, __) {
          StateEnum state = value as StateEnum;
          if (state == StateEnum.loading) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ShimmerListTileWidget();
                  },
                ),
              ),
            );
          } else if (state == StateEnum.success) {
            if (controller.tickets.isNotEmpty) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.buscarTodos();
                    },
                    child: ListView.builder(
                      itemCount: controller.tickets.length,
                      itemBuilder: (context, index) {
                        IconData icon;
                        String formaPg =
                            controller.tickets[index].formaDePagamento!.tipo!;

                        if (formaPg == "1") {
                          icon = Icons.picture_as_pdf_outlined;
                        } else if (formaPg == "2") {
                          icon = Icons.credit_card_outlined;
                        } else if (formaPg == "3") {
                          icon = Icons.request_quote_outlined;
                        } else if (formaPg == "6") {
                          icon = Icons.qr_code_2_outlined;
                        } else {
                          icon = Icons.article_outlined;
                        }

                        String statusPg = "";
                        Color statusColor = AppColors.stroke;
                        if (controller.tickets[index].pendente!) {
                          statusPg = "Aguardando pagamento";
                          statusColor = Colors.amber;
                        }

                        if (controller.tickets[index].cancelado!) {
                          statusPg = "Cancelado";
                          statusColor = AppColors.delete;
                        }

                        if (controller.tickets[index].pago!) {
                          statusPg = "Pagamento concluído";
                          statusColor = AppColors.success;
                        }

                        return Column(
                          children: [
                            Container(
                              color: AppColors.shape,
                              child: ListTile(
                                onTap: () async {
                                  String _url =
                                      controller.tickets[index].faturaUrl!;
                                  await canLaunch(_url)
                                      ? await launch(_url)
                                      : throw 'Could not launch $_url';
                                },
                                title: Text(
                                  controller
                                      .tickets[index].formaDePagamento!.nome!,
                                  style: TextStyles.titleListTile,
                                ),
                                subtitle: Text(
                                    '${formatCurrency.format(controller.tickets[index].total!)} | $statusPg'),
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  child: Icon(icon),
                                ),
                                trailing: Text(
                                  controller.getFormatedDate(
                                      controller.tickets[index].criado!),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 13,
                              ),
                              child: Container(
                                width: size.width,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    child: Text(
                      "Você ainda não adquiriu nenhum ticket.",
                      style: TextStyles.input,
                    ),
                  ),
                ),
              );
            }
          } else {
            return Expanded(
              flex: 1,
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
                        controller.buscarTodos();
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
    );
  }
}
