import 'package:flutter/material.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final kToday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: TitlePageWidget(
          title: "Minha agenda",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TableCalendar(
          locale: 'pt_BR',
          firstDay: DateTime.now(),
          focusedDay: DateTime.now(),
          lastDay: DateTime.now(),
          calendarFormat: CalendarFormat.month,
        ),
      ),
    );
  }
}
