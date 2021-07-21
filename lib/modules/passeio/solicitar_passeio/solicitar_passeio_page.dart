import 'package:flutter/material.dart';
import 'package:tutor/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:tutor/shared/widgets/custom_app_bar_widget/custom_app_bar_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class SolicitarPasseioPage extends StatefulWidget {
  const SolicitarPasseioPage({Key? key}) : super(key: key);

  @override
  _SolicitarPasseioPageState createState() => _SolicitarPasseioPageState();
}

class _SolicitarPasseioPageState extends State<SolicitarPasseioPage> {
  int paginaAtual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBarWidget(),
      ),
      body: Container(
        child: Column(
          children: [
            TitlePageWidget(
              title: "Solicitar novo passeio.",
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonsWidget(
        primaryLabel: "Cancelar",
        primaryOnPressed: () {
          Navigator.pushReplacementNamed(context, "/home");
        },
        secondaryLabel: "Solicitar",
        secondaryOnPressed: () {
          Navigator.pushReplacementNamed(context, "/home");
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
