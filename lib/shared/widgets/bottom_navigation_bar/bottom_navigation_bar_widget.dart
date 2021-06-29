import 'package:flutter/material.dart';
import 'package:tutor/modules/agenda/agenda_page.dart';
import 'package:tutor/modules/dogwalkers/dogwalkers_page.dart';
import 'package:tutor/modules/meus_caes/meus_caes_page.dart';
import 'package:tutor/modules/meus_passeios/meus_passeios_page.dart';
import 'package:tutor/modules/meus_tickets/meus_tickets_page.dart';
import 'package:tutor/shared/themes/app_colors.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int paginaAtual;
  const BottomNavigationBarWidget({Key? key, required this.paginaAtual})
      : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 58,
                    width: 58,
                    decoration: widget.paginaAtual == 1
                        ? BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          )
                        : null,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => MeusPasseiosPage(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.history_outlined,
                        color: widget.paginaAtual == 1
                            ? AppColors.background
                            : null,
                        size: widget.paginaAtual == 1 ? 32 : 25,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 58,
                    width: 58,
                    decoration: widget.paginaAtual == 2
                        ? BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          )
                        : null,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => DogwalkersPage(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.nordic_walking_outlined,
                        color: widget.paginaAtual == 2
                            ? AppColors.background
                            : null,
                        size: widget.paginaAtual == 2 ? 32 : 25,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 58,
                    width: 58,
                    decoration: widget.paginaAtual == 3
                        ? BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          )
                        : null,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => AgendaPage(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.event_outlined,
                        color: widget.paginaAtual == 3
                            ? AppColors.background
                            : null,
                        size: widget.paginaAtual == 3 ? 35 : 25,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 58,
                    width: 58,
                    decoration: widget.paginaAtual == 4
                        ? BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          )
                        : null,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => MeusCaesPage(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.pets_outlined,
                        color: widget.paginaAtual == 4
                            ? AppColors.background
                            : null,
                        size: widget.paginaAtual == 4 ? 32 : 25,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 58,
                    width: 58,
                    decoration: widget.paginaAtual == 5
                        ? BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5),
                          )
                        : null,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => MeusTicketsPage(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.payments_outlined,
                        color: widget.paginaAtual == 5
                            ? AppColors.background
                            : null,
                        size: widget.paginaAtual == 5 ? 32 : 25,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
