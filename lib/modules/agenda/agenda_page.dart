import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tutor/shared/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:tutor/shared/widgets/custom_app_bar_widget/custom_app_bar_widget.dart';
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
