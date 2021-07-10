import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_passeios/meus_passeios_list_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class MeusPasseiosPage extends StatefulWidget {
  const MeusPasseiosPage({Key? key}) : super(key: key);

  @override
  _MeusPasseiosPageState createState() => _MeusPasseiosPageState();
}

class _MeusPasseiosPageState extends State<MeusPasseiosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TitlePageWidget(
            title: "Meus passeios",
          ),
          MeusPasseiosListWidget(),
        ],
      ),
    );
  }
}
