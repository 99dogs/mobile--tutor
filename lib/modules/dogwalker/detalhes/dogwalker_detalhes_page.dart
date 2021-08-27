import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:tutor/modules/dogwalker/detalhes/dogwalker_detalhes_controller.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:tutor/shared/widgets/stars_rating/star_rating_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class DogwalkerDetalhesPage extends StatefulWidget {
  final int id;
  const DogwalkerDetalhesPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _DogwalkerDetalhesPageState createState() => _DogwalkerDetalhesPageState();
}

class _DogwalkerDetalhesPageState extends State<DogwalkerDetalhesPage> {
  final controller = DogwalkerDetalhesController();
  bool horarioAtendimentoExpanded = false;
  bool qualificacaoExpanded = false;
  bool avalicaoExpanded = false;

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.init(widget.id);
  }

  final diasSemana = {
    1: "Segunda-feira",
    2: "Terça-feira",
    3: "Quarta-feira",
    4: "Quinta-feira",
    5: "Sexta-feira",
    6: "Sábado",
    0: "Domingo",
  };

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                color: AppColors.primary,
              ),
              Container(
                color: AppColors.background,
                child: Column(
                  children: [
                    TitlePageWidget(
                      title: "Informações do dog walker",
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
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                  } else if (state == StateEnum.success) {
                    return Column(
                      children: [
                        SizedBox(height: 16),
                        Visibility(
                          visible: controller.dogwalker.fotoUrl != null
                              ? true
                              : false,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                image: NetworkImage(
                                  controller.dogwalker.fotoUrl!,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 5),
                          child: Text(
                            controller.dogwalker.nome!,
                            style: TextStyles.titleBoldHeading,
                          ),
                        ),
                        Text(
                          controller.dogwalker.telefone != null
                              ? 'controller.dogwalker.telefone!'
                              : 'Telefone não específicado.',
                          style: TextStyles.buttonGray,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (controller.tutor.qtdeTicketDisponivel! > 0) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  "/passeio/add",
                                  arguments: controller.dogwalker.id,
                                );
                              } else {
                                CoolAlert.show(
                                  context: context,
                                  title: "Atenção\n",
                                  text:
                                      "Você não possui ticket suficiente para agendar novos passeios.",
                                  backgroundColor: AppColors.primary,
                                  type: CoolAlertType.warning,
                                  confirmBtnText: "Fechar",
                                  confirmBtnColor: AppColors.shape,
                                  confirmBtnTextStyle: TextStyles.buttonGray,
                                );
                              }
                            },
                            icon: Icon(
                              Icons.calendar_today_outlined,
                              size: 19,
                            ),
                            label: Text("Agendar comigo"),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  controller.formataData(
                                      controller.dogwalker.criado!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "Conosco desde",
                                    style: TextStyles.input,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text("0"),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "Passeios efetuados",
                                    style: TextStyles.input,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                StarRatingWidget(
                                  rating: controller.dogwalker.avaliacao!,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "Avaliação",
                                    style: TextStyles.input,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 16),
                        ListTile(
                          title: Text("Horário de atendimento"),
                          trailing: Icon(Icons.arrow_upward_outlined),
                          leading: Icon(Icons.list_alt_outlined),
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: AppColors.background,
                                  child: ListView.builder(
                                    itemCount: controller.horarios.length,
                                    itemBuilder: (context, index) {
                                      String diaDaSemana = diasSemana[controller
                                          .horarios[index].diaSemana] as String;
                                      return ListTile(
                                        title: Text(diaDaSemana),
                                        subtitle: Text(controller
                                                .horarios[index].horaInicio! +
                                            " - " +
                                            controller
                                                .horarios[index].horaFinal!),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Qualificações"),
                          trailing: Icon(Icons.arrow_upward_outlined),
                          leading: Icon(Icons.bookmarks_outlined),
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: AppColors.background,
                                  child: ListView.builder(
                                    itemCount: controller.qualificacoes.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(controller
                                                .qualificacoes[index]
                                                .modalidade! +
                                            " / " +
                                            controller
                                                .qualificacoes[index].titulo!),
                                        subtitle: Text(controller
                                            .qualificacoes[index].descricao!),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Avaliações"),
                          trailing: Icon(Icons.arrow_upward_outlined),
                          leading: Icon(Icons.stars_outlined),
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: AppColors.background,
                                  child: ListView.builder(
                                    itemCount: controller.qualificacoes.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(controller
                                                .qualificacoes[index]
                                                .modalidade! +
                                            " / " +
                                            controller
                                                .qualificacoes[index].titulo!),
                                        subtitle: Text(controller
                                            .qualificacoes[index].descricao!),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Divider(),
                      ],
                    );
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
