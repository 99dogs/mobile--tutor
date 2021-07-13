import 'package:flutter/material.dart';
import 'package:tutor/modules/agenda/agenda_page.dart';
import 'package:tutor/modules/dogwalkers/dogwalkers_page.dart';
import 'package:tutor/modules/home/home_page.dart';
import 'package:tutor/modules/login/login_page.dart';
import 'package:tutor/modules/meu_perfil/meu_perfil_page.dart';
import 'package:tutor/modules/meus_caes/alterar_cao_page.dart';
import 'package:tutor/modules/meus_caes/cadastrar_cao_page.dart';
import 'package:tutor/modules/meus_caes/detalhes_page.dart';
import 'package:tutor/modules/meus_caes/meus_caes_page.dart';
import 'package:tutor/modules/meus_passeios/meus_passeios_page.dart';
import 'package:tutor/modules/meus_tickets/meus_tickets_page.dart';
import 'package:tutor/modules/meus_tickets/solicitar_ticket_page.dart';
import 'package:tutor/modules/splash/splash_page.dart';
import 'package:tutor/shared/themes/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "99Dogs - Tutor",
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: "/splash",
      home: AgendaPage(),
      routes: {
        "/splash": (context) => SplashPage(),
        "/login": (context) => LoginPage(),
        "/home": (context) => HomePage(),
        "/perfil": (context) => MeuPerfilPage(),
        "/agenda": (context) => AgendaPage(),
        "/passeio/list": (context) => MeusPasseiosPage(),
        "/cachorro/list": (context) => MeusCaesPage(),
        "/cachorro/detail": (context) => DetalhesPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/cachorro/add": (context) => CadastrarCaoPage(),
        "/cachorro/edit": (context) => AlterarCaoPage(
              id: ModalRoute.of(context)!.settings.arguments as int,
            ),
        "/dogwalker/list": (context) => DogwalkersPage(),
        "/ticket/list": (context) => MeusTicketsPage(),
        "/ticket/add": (context) => SolicitarTicketPage(),
      },
    );
  }
}
