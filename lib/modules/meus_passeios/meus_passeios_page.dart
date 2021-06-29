import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_passeios/meus_passeios_list_widget.dart';
import 'package:tutor/modules/meus_passeios/solicitar_passeio_page.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:tutor/shared/widgets/custom_app_bar_widget/custom_app_bar_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class MeusPasseiosPage extends StatefulWidget {
  const MeusPasseiosPage({Key? key}) : super(key: key);

  @override
  _MeusPasseiosPageState createState() => _MeusPasseiosPageState();
}

class _MeusPasseiosPageState extends State<MeusPasseiosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBarWidget(),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                TitlePageWidget(
                  title: "Meus passeios",
                ),
                MeusPasseiosListWidget(),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => SolicitarPasseioPage(),
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
      bottomNavigationBar: BottomNavigationBarWidget(paginaAtual: 1),
    );
  }
}
