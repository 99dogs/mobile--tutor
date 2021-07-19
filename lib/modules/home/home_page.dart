import 'package:flutter/material.dart';
import 'package:tutor/modules/agenda/agenda_page.dart';
import 'package:tutor/modules/dogwalker/dogwalkers/dogwalkers_page.dart';
import 'package:tutor/modules/home/home_controller.dart';
import 'package:tutor/modules/cachorro/meus_caes/meus_caes_page.dart';
import 'package:tutor/modules/passeio/meus_passeios/meus_passeios_page.dart';
import 'package:tutor/modules/ticket/meus_tickets/meus_tickets_page.dart';
import 'package:tutor/shared/auth/auth_controller.dart';
import 'package:tutor/shared/models/usuario_logado_model.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_images.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import 'package:tutor/shared/widgets/drawer/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final authController = AuthController();
  UsuarioLogadoModel _usuario = UsuarioLogadoModel();

  final pages = [
    MeusPasseiosPage(),
    DogwalkersPage(),
    AgendaPage(),
    MeusCaesPage(),
    MeusTicketsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: FutureBuilder(
            future: authController.obterSessao(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _usuario = snapshot.data as UsuarioLogadoModel;
                return AppBar(
                  elevation: 0,
                  brightness: Brightness.dark,
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: new Icon(Icons.list_sharp),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  title: Text.rich(
                    TextSpan(
                      style: TextStyles.titleBoldBackground,
                      text: "Olá, ",
                      children: [
                        TextSpan(text: _usuario.nome),
                      ],
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                "/perfil",
                              );
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.background,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: AssetImage(AppImages.logoDogwalker),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        body: Container(
          color: AppColors.background,
          child: ValueListenableBuilder(
            valueListenable: homeController.paginaAtual,
            builder: (context, value, child) {
              int index = value as int;
              return pages[index];
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          paginaAtual: homeController.paginaAtual.value,
        ),
      ),
    );
  }
}
