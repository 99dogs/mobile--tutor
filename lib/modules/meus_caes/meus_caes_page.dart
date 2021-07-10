import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_caes/meus_caes_controller.dart';
import 'package:tutor/modules/meus_caes/meus_caes_list_widget.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class MeusCaesPage extends StatefulWidget {
  const MeusCaesPage({Key? key}) : super(key: key);

  @override
  _MeusCaesPageState createState() => _MeusCaesPageState();
}

class _MeusCaesPageState extends State<MeusCaesPage> {
  final controller = MeusCaesController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TitlePageWidget(
            title: "Meus cães",
          ),
          MeusCaesListWidget(),
          ValueListenableBuilder(
            valueListenable: controller.state,
            builder: (_, value, __) {
              StateEnum state = value as StateEnum;
              if (state == StateEnum.success) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: FloatingActionButton(
                        child: const Icon(Icons.add),
                        backgroundColor: AppColors.successSecondary,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, "/cachorro/add");
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
