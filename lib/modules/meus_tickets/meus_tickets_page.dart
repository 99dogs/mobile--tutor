import 'package:flutter/material.dart';
import 'package:tutor/shared/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:tutor/shared/widgets/custom_app_bar_widget/custom_app_bar_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class MeusTicketsPage extends StatefulWidget {
  const MeusTicketsPage({Key? key}) : super(key: key);

  @override
  _MeusTicketsPageState createState() => _MeusTicketsPageState();
}

class _MeusTicketsPageState extends State<MeusTicketsPage> {
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
                  title: "Meus tickets",
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(paginaAtual: 5),
    );
  }
}
