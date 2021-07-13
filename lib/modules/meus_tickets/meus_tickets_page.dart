import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_tickets/meus_tickets_list_widget.dart';
import 'package:tutor/shared/themes/app_colors.dart';
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
      key: UniqueKey(),
      child: Column(
        children: [
          TitlePageWidget(
            title: "Meus tickets",
          ),
          MeusTicketsListWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  backgroundColor: AppColors.successSecondary,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/ticket/add");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
