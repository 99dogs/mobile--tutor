import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:tutor/modules/meus_tickets/solicitar_ticket_controller.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/forma_de_pagamento_model.dart';
import 'package:tutor/shared/models/ticket_model.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:tutor/shared/widgets/input_text/input_text_widget.dart';
import 'package:tutor/shared/widgets/shimmer_input/shimmer_input_widget.dart';
import 'package:tutor/shared/widgets/ticket_info/ticket_info_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class SolicitarTicketPage extends StatefulWidget {
  const SolicitarTicketPage({Key? key}) : super(key: key);

  @override
  _SolicitarTicketPageState createState() => _SolicitarTicketPageState();
}

class _SolicitarTicketPageState extends State<SolicitarTicketPage> {
  final controller = SolicitarTicketController();
  final cpfPagadorTextController = MaskedTextController(mask: "000.000.000-00");

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.init();
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
                      title: "Solicitar um novo ticket",
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 25,
                              ),
                              child: TicketInfoWidget(),
                            ),
                            Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  InputTextWidget(
                                    label: "Qual a quantidade desejada?",
                                    icon: Icons
                                        .production_quantity_limits_outlined,
                                    textInputType: TextInputType.number,
                                    validator: TicketModel().validarQuantidade,
                                    onChanged: (value) {
                                      controller.onChange(
                                        quantidade: int.parse(value),
                                      );
                                    },
                                  ),
                                  AnimatedCard(
                                    direction: AnimatedCardDirection.left,
                                    child: DropdownButtonFormField(
                                      validator:
                                          TicketModel().validarFormaPagamento,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isExpanded: true,
                                      iconSize: 30,
                                      style: TextStyle(color: Colors.blue),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        labelText: "E forma de pagamento?",
                                        labelStyle: TextStyles.buttonGray,
                                        icon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 18,
                                              ),
                                              child: Icon(
                                                Icons.payments_outlined,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              height: 48,
                                              color: AppColors.stroke,
                                            )
                                          ],
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      items: controller.formasPagamento
                                          .map((FormaDePagamentoModel formaPg) {
                                        return DropdownMenuItem<
                                            FormaDePagamentoModel>(
                                          value: formaPg,
                                          child: Text(formaPg.nome!),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        FormaDePagamentoModel value =
                                            val as FormaDePagamentoModel;
                                        controller.onChange(
                                            formaDePagamentoId: value.id);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: AppColors.stroke,
                                    ),
                                  ),
                                  InputTextWidget(
                                    label: "Informe seu CPF",
                                    icon: Icons.pin,
                                    textInputType: TextInputType.number,
                                    controller: cpfPagadorTextController,
                                    validator: TicketModel().validarCpf,
                                    onChanged: (value) {
                                      controller.onChange(
                                        cpfPagador: value,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                                controller.init();
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
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: controller.stateSolicitacao,
          builder: (_, value, __) {
            StateEnum state = value as StateEnum;
            if (state == StateEnum.loading) {
              return Container(
                height: 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else {
              return BottomButtonsWidget(
                primaryLabel: "Cancelar",
                primaryOnPressed: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
                secondaryLabel: "Solicitar",
                secondaryOnPressed: () async {
                  String? response = await controller.solicitar();
                  if (response != null) {
                    if (response.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response),
                        ),
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, "/home");
                    }
                  }
                },
                enableSecondaryColor: true,
              );
            }
          },
        ),
      ),
    );
  }
}
