import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_tickets/meus_tickets_list_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class MeusTicketsPage extends StatefulWidget {
  const MeusTicketsPage({Key? key}) : super(key: key);

  @override
  _MeusTicketsPageState createState() => _MeusTicketsPageState();
}

class _MeusTicketsPageState extends State<MeusTicketsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TitlePageWidget(
            title: "Meus tickets",
          ),
          MeusTicketsListWidget(),
        ],
      ),
    );
  }
}
