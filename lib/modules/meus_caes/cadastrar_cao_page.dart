import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor/modules/home/home_controller.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:tutor/shared/widgets/custom_app_bar_widget/custom_app_bar_widget.dart';
import 'package:tutor/shared/widgets/input_text/input_text_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class CadastrarCaoPage extends StatefulWidget {
  const CadastrarCaoPage({Key? key}) : super(key: key);

  @override
  _CadastrarCaoPageState createState() => _CadastrarCaoPageState();
}

class _CadastrarCaoPageState extends State<CadastrarCaoPage> {
  final homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                      title: "Cadastrar um cão.",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              Form(
                child: Column(
                  children: [
                    InputTextWidget(
                      label: "Qual é o nome?",
                      icon: FontAwesomeIcons.dog,
                      onChanged: (value) {},
                    ),
                    InputTextWidget(
                      label: "Qual é o porte?",
                      icon: FontAwesomeIcons.weightHanging,
                      onChanged: (value) {},
                    ),
                    InputTextWidget(
                      label: "Qual é a raça?",
                      icon: Icons.pets_outlined,
                      onChanged: (value) {},
                    ),
                    InputTextWidget(
                      label: "Como é o comportamento?",
                      icon: FontAwesomeIcons.smile,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButtonsWidget(
        primaryLabel: "Cancelar",
        primaryOnPressed: () {
          homeController.mudarDePagina(3);
          Navigator.pushReplacementNamed(context, "/home");
        },
        secondaryLabel: "Cadastrar",
        secondaryOnPressed: () {
          homeController.mudarDePagina(3);
          Navigator.pushReplacementNamed(context, "/home");
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
