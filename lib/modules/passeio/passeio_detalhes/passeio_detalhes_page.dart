import 'package:flutter/material.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class PasseioDetalhesPage extends StatefulWidget {
  final int id;
  const PasseioDetalhesPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PasseioDetalhesPageState createState() => _PasseioDetalhesPageState();
}

class _PasseioDetalhesPageState extends State<PasseioDetalhesPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: AppColors.background,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                color: AppColors.primary,
              ),
              Container(
                color: AppColors.background,
                child: Column(
                  children: [
                    TitlePageWidget(
                      title: "Informações do passeio",
                      enableBackButton: true,
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
