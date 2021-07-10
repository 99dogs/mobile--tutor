import 'package:flutter/material.dart';
import 'package:tutor/modules/login/login_controller.dart';
import 'package:tutor/shared/themes/app_colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController();

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Encerrar sessão"),
            onTap: () {
              loginController.encerrarSessao(context);
            },
          ),
        ],
      ),
    );
  }
}
