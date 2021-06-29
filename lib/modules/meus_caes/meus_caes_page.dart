import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_caes/cadastrar_cao_page.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:tutor/shared/widgets/custom_app_bar_widget/custom_app_bar_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class MeusCaesPage extends StatefulWidget {
  const MeusCaesPage({Key? key}) : super(key: key);

  @override
  _MeusCaesPageState createState() => _MeusCaesPageState();
}

class _MeusCaesPageState extends State<MeusCaesPage> {
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
              title: "Meus cães",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => CadastrarCaoPage(),
              transitionDuration: Duration(seconds: 0),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: AppColors.successSecondary,
      ),
      bottomNavigationBar: BottomNavigationBarWidget(paginaAtual: 4),
    );
  }
}
