import 'package:flutter/material.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/input_text/input_text_widget.dart';
import 'package:tutor/shared/widgets/social_login_button/google_social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: size.height * 0.2,
              child: Container(
                height: size.height * 0.7,
                width: size.width - 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.background,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "99Dogs",
                            style: TextStyles.titleLogo,
                          ),
                          Text(
                            "Melhor lugar para encontrar dogwalkers.",
                            style: TextStyles.captionBoldBody,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 40,
                      ),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        child: Column(
                          children: [
                            InputTextWidget(
                              label: "Digite seu e-mail.",
                              icon: Icons.email_outlined,
                              onChanged: (value) {},
                            ),
                            InputTextWidget(
                              label: "Digite sua senha.",
                              icon: Icons.lock_outline,
                              onChanged: (value) {},
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  "/agenda",
                                );
                              },
                              child: Text("Entrar"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "ou",
                        style: TextStyles.captionBody,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 70,
                      ),
                      child: GoogleSocialLoginButton(
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
