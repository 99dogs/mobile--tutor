import 'package:animated_card/animated_card.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor/modules/home/home_controller.dart';
import 'package:tutor/modules/passeio/solicitar_passeio/solicitar_passeio_controller.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/models/cachorro_model.dart';
import 'package:tutor/shared/models/passeio_model.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/bottom_buttons/bottom_back_button_widget.dart';
import 'package:tutor/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:tutor/shared/widgets/input_text/input_text_widget.dart';
import 'package:tutor/shared/widgets/multiselect_formfield_widget/multi_select_form_field_widget.dart';
import 'package:tutor/shared/widgets/shimmer_input/shimmer_input_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:intl/intl.dart';

class SolicitarPasseioPage extends StatefulWidget {
  final int dogwalkerId;
  const SolicitarPasseioPage({
    Key? key,
    required this.dogwalkerId,
  }) : super(key: key);

  @override
  _SolicitarPasseioPageState createState() => _SolicitarPasseioPageState();
}

class _SolicitarPasseioPageState extends State<SolicitarPasseioPage> {
  final homeController = HomeController();
  final controller = SolicitarPasseioController();

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.init(widget.dogwalkerId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
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
                      title: "Solicitar novo passeio",
                      enableBackButton: true,
                      routePage: "/dogwalker/detail",
                      args: widget.dogwalkerId,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: SingleChildScrollView(
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                InputTextWidget(
                                  label: "Dog walker",
                                  icon: Icons.nordic_walking_outlined,
                                  initialValue: controller.dogwalker.nome,
                                  enable: false,
                                  onChanged: (value) {},
                                ),
                                AnimatedCard(
                                  direction: AnimatedCardDirection.right,
                                  child: DropdownButtonFormField(
                                    validator: (value) {
                                      CachorroModel cachorro =
                                          value as CachorroModel;
                                      if (cachorro.id == null) {
                                        return "Você deve selecionar um cão.";
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                    iconSize: 30,
                                    style: TextStyle(color: Colors.blue),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      labelText: "Qual cão irá passear?",
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
                                                FontAwesomeIcons.paw,
                                                color: AppColors.primary,
                                              )),
                                          Container(
                                            width: 1,
                                            height: 48,
                                            color: AppColors.stroke,
                                          )
                                        ],
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    items: controller.cachorros
                                        .map((CachorroModel cachorro) {
                                      return DropdownMenuItem<CachorroModel>(
                                        value: cachorro,
                                        child: Text(cachorro.nome!),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      CachorroModel cachorro =
                                          val as CachorroModel;
                                      controller.setCachorroId = cachorro.id!;
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
                                AnimatedCard(
                                  direction: AnimatedCardDirection.right,
                                  child: DateTimeField(
                                    format: DateFormat("dd/MM/yyyy HH:mm"),
                                    onShowPicker:
                                        (context, currentValue) async {
                                      final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100),
                                      );
                                      if (date != null) {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                            currentValue ?? DateTime.now(),
                                          ),
                                        );
                                        return DateTimeField.combine(
                                            date, time);
                                      } else {
                                        return currentValue;
                                      }
                                    },
                                    onChanged: (value) async {
                                      if (value == null) return;

                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  new CircularProgressIndicator(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: new Text(
                                                      "Verificando disponibilidade...",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );

                                      bool disponivel = await controller
                                          .verificarDisponibilidade(value);

                                      if (disponivel == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'O horário escolhido não está disponível.',
                                            ),
                                          ),
                                        );

                                        Navigator.pop(context);

                                        return;
                                      } else {
                                        controller.setDataHora = value;
                                        Navigator.pop(context);
                                      }
                                    },
                                    validator: (datetime) {
                                      if (datetime == null) {
                                        return "Escolha um horário";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      labelText: "Qual horário você gostaria?",
                                      labelStyle: TextStyles.buttonGray,
                                      icon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 18,
                                            ),
                                            child: Icon(
                                              FontAwesomeIcons.calendarDay,
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
                              ],
                            ),
                          ),
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
                                controller.init(widget.dogwalkerId);
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
          valueListenable: controller.state,
          builder: (_, value, __) {
            StateEnum state = value as StateEnum;
            if (state == StateEnum.success) {
              return BottomButtonsWidget(
                primaryLabel: "Voltar",
                primaryOnPressed: () {
                  Navigator.pushReplacementNamed(context, "/dogwalker/detail",
                      arguments: widget.dogwalkerId);
                },
                secondaryLabel: "Solicitar",
                secondaryOnPressed: () async {
                  try {
                    PasseioModel? novoPasseio = await controller.solicitar();

                    homeController.mudarDePagina(0);
                    Navigator.pushReplacementNamed(
                      context,
                      "/passeio/detail",
                      arguments: novoPasseio!.id,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Ocorreu um problema, tente novamente.",
                        ),
                      ),
                    );
                  }
                },
                enableSecondaryColor: true,
              );
            } else if (state == StateEnum.error) {
              return BottomBackButtonWidget(
                label: "Voltar",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
              );
            } else {
              return BottomBackButtonWidget(
                label: "Carregando...",
                onPressed: () {},
              );
            }
          },
        ),
      ),
    );
  }
}
