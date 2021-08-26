import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/social_login_button/email_and_pass_login_button.dart';
import 'package:tutor/shared/widgets/social_login_button/google_social_login_button.dart';
import 'package:tutor/shared/widgets/social_login_button/register_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                height: size.height * 0.6,
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 70,
                      ),
                      child: EmailAndPassLoginButton(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/login");
                        },
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
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 70,
                      ),
                      child: RegisterButton(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/register");
                        },
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
