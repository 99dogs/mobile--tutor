import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:tutor/shared/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:tutor/shared/widgets/custom_app_bar_widget/custom_app_bar_widget.dart';
import 'package:tutor/shared/widgets/input_text/input_text_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class CadastrarCaoPage extends StatefulWidget {
  const CadastrarCaoPage({Key? key}) : super(key: key);

  @override
  _CadastrarCaoPageState createState() => _CadastrarCaoPageState();
}

class _CadastrarCaoPageState extends State<CadastrarCaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBarWidget(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
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
          Navigator.pushReplacementNamed(context, "/cachorro/list");
        },
        secondaryLabel: "Cadastrar",
        secondaryOnPressed: () {
          Navigator.pushReplacementNamed(context, "/cachorro/list");
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
