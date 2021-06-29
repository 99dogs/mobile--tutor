import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_passeios/meus_passeios_controller.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_images.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';

class MeusPasseiosListWidget extends StatefulWidget {
  const MeusPasseiosListWidget({Key? key}) : super(key: key);

  @override
  _MeusPasseiosListWidgetState createState() => _MeusPasseiosListWidgetState();
}

class _MeusPasseiosListWidgetState extends State<MeusPasseiosListWidget> {
  final controller = MeusPasseiosController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: AnimatedCard(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "DogWalkers SRS",
                          style: TextStyles.titleListTile,
                        ),
                        subtitle: Text("Finalizado"),
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage(AppImages.logoDogwalker),
                            ),
                          ),
                        ),
                        trailing: Text(
                          "28/06/2020 \n13:00h",
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCard(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "DogWalkers SRS",
                        style: TextStyles.titleListTile,
                      ),
                      subtitle: Text("Aguardando confirmação"),
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: AssetImage(AppImages.logoDogwalker),
                          ),
                        ),
                      ),
                      trailing: Text(
                        "29/06/2020 \n14:30h",
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.delete,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
