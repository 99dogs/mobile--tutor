import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_caes/meus_caes_list_widget.dart';
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
    return Container(
      child: Column(
        children: [
          TitlePageWidget(
            title: "Meus cães",
          ),
          MeusCaesListWidget(),
        ],
      ),
    );
  }
}
