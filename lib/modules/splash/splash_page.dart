import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:tutor/modules/splash/splash_controller.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = SplashController();
    controller.delay(context);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250.0,
          child: DefaultTextStyle(
            style: TextStyles.titleLogo,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  '99',
                  textStyle: TextStyles.titleLogoPrimary,
                ),
                TypewriterAnimatedText('DOGS'),
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
      ),
    );
  }
}
