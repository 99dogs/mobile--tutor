import 'package:flutter/material.dart';
import 'package:tutor/modules/agenda/agenda_page.dart';
import 'package:tutor/modules/cachorro/alterar_cao/alterar_cao_page.dart';
import 'package:tutor/modules/cachorro/cadastrar_cao/cadastrar_cao_page.dart';
import 'package:tutor/modules/cachorro/detalhes/detalhes_page.dart';
import 'package:tutor/modules/cachorro/meus_caes/meus_caes_page.dart';
import 'package:tutor/modules/dogwalker/detalhes/dogwalker_detalhes_page.dart';
import 'package:tutor/modules/dogwalker/dogwalkers/dogwalkers_page.dart';
import 'package:tutor/modules/home/home_page.dart';
import 'package:tutor/modules/login/login_page.dart';
import 'package:tutor/modules/passeio/meus_passeios/meus_passeios_page.dart';
import 'package:tutor/modules/passeio/passeio_detalhes/passeio_detalhes_page.dart';
import 'package:tutor/modules/passeio/solicitar_passeio/solicitar_passeio_page.dart';
import 'package:tutor/modules/perfil/meu_perfil/meu_perfil_page.dart';
import 'package:tutor/modules/register/register_page.dart';
import 'package:tutor/modules/signin/signin_page.dart';
import 'package:tutor/modules/ticket/detalhes/detalhes_ticket_page.dart';
import 'package:tutor/modules/ticket/meus_tickets/meus_tickets_page.dart';
import 'package:tutor/modules/ticket/solicitar_ticket/solicitar_ticket_page.dart';
import 'package:tutor/shared/themes/app_colors.dart';

class AppWdiget extends StatelessWidget {
  const AppWdiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "99Dogs - Tutor",
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: "/signin",
      home: AgendaPage(),
      routes: {
        "/signin": (context) => SignInPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/home": (context) => HomePage(),
        "/perfil": (context) => MeuPerfilPage(),
        "/agenda": (context) => AgendaPage(),
        "/passeio/list": (context) => MeusPasseiosPage(),
        "/passeio/add": (context) => SolicitarPasseioPage(
              dogwalkerId: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/passeio/detail": (context) => PasseioDetalhesPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/cachorro/list": (context) => MeusCaesPage(),
        "/cachorro/detail": (context) => DetalhesPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/cachorro/add": (context) => CadastrarCaoPage(),
        "/cachorro/edit": (context) => AlterarCaoPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/dogwalker/list": (context) => DogwalkersPage(),
        "/dogwalker/detail": (context) => DogwalkerDetalhesPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/ticket/list": (context) => MeusTicketsPage(),
        "/ticket/add": (context) => SolicitarTicketPage(),
        "/ticket/detail": (context) => DetalhesTicketPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
      },
    );
  }
}
