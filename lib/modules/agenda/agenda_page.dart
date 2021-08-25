import 'package:flutter/material.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Column(
        children: [
          TitlePageWidget(
            title: "Agenda",
          ),
        ],
      ),
    );
  }
}
