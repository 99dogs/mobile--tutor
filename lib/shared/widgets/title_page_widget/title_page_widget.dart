import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';

class TitlePageWidget extends StatelessWidget {
  final String title;
  const TitlePageWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.primary,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border.all(
                color: AppColors.background,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  AnimatedCard(
                    duration: Duration(milliseconds: 300),
                    direction: AnimatedCardDirection.left,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        title,
                        style: TextStyles.titleBoldHeading,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.stroke,
          ),
        ),
      ],
    );
  }
}
