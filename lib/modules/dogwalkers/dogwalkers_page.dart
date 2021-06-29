import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_passeios/meus_passeios_list_widget.dart';
import 'package:tutor/shared/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:tutor/shared/widgets/custom_app_bar_widget/custom_app_bar_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class DogwalkersPage extends StatefulWidget {
  const DogwalkersPage({Key? key}) : super(key: key);

  @override
  _DogwalkersPageState createState() => _DogwalkersPageState();
}

class _DogwalkersPageState extends State<DogwalkersPage> {
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
                  title: "Dog walkers",
                ),
                MeusPasseiosListWidget(),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(paginaAtual: 2),
    );
  }
}
