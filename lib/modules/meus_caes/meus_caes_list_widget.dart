import 'package:flutter/material.dart';
import 'package:tutor/modules/meus_caes/meus_caes_controller.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_images.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/shimmer_list_tile/shimmer_list_tile.dart';

class MeusCaesListWidget extends StatefulWidget {
  const MeusCaesListWidget({Key? key}) : super(key: key);

  @override
  _MeusCaesListWidgetState createState() => _MeusCaesListWidgetState();
}

class _MeusCaesListWidgetState extends State<MeusCaesListWidget> {
  final controller = MeusCaesController();

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (_, value, __) {
          MeusCaesState state = value as MeusCaesState;
          if (state == MeusCaesState.loading) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ShimmerListTileWidget();
                  },
                ),
              ),
            );
          } else if (state == MeusCaesState.success) {
            if (controller.cachorros.isNotEmpty) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.buscarTodos();
                    },
                    child: ListView.builder(
                      itemCount: controller.cachorros.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              color: AppColors.shape,
                              child: ListTile(
                                title: Text(
                                  controller.cachorros[index].nome!,
                                  style: TextStyles.titleListTile,
                                ),
                                subtitle: Text(
                                    controller.cachorros[index].raca!.nome!),
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      image:
                                          AssetImage(AppImages.logoDogwalker),
                                    ),
                                  ),
                                ),
                                trailing: Text(
                                  controller.cachorros[index].porte!.nome!,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 13,
                              ),
                              child: Container(
                                width: size.width,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    child: Text(
                      "Você ainda não cadastrou nenhum cão.",
                      style: TextStyles.input,
                    ),
                  ),
                ),
              );
            }
          } else {
            return Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Ocorreu um problema inesperado.",
                      style: TextStyles.input,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.buscarTodos();
                      },
                      icon: Icon(Icons.refresh_outlined),
                      label: Text("Tentar novamente"),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
