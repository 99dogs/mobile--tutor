import 'package:flutter/material.dart';
import 'package:tutor/modules/dogwalker/dogwalkers/dogwalkers_controller.dart';
import 'package:tutor/shared/enum/state_enum.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/themes/app_images.dart';
import 'package:tutor/shared/themes/app_text_styles.dart';
import 'package:tutor/shared/widgets/shimmer_list_tile/shimmer_list_tile.dart';
import 'package:tutor/shared/widgets/stars_rating/star_rating_widget.dart';

class DogwalkersListWidget extends StatefulWidget {
  const DogwalkersListWidget({Key? key}) : super(key: key);

  @override
  _DogwalkersListWidgetState createState() => _DogwalkersListWidgetState();
}

class _DogwalkersListWidgetState extends State<DogwalkersListWidget> {
  final controller = DogwalkersController();

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
          StateEnum state = value as StateEnum;
          if (state == StateEnum.loading) {
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
          } else if (state == StateEnum.success) {
            if (controller.dogwalkers.isNotEmpty) {
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
                      itemCount: controller.dogwalkers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(
                                      0,
                                      3,
                                    ), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    "/dogwalker/detail",
                                    arguments: controller.dogwalkers[index].id,
                                  );
                                },
                                title: Text(
                                  controller.dogwalkers[index].nome!,
                                  style: TextStyles.buttonBoldGray,
                                ),
                                subtitle: StarRatingWidget(
                                  rating:
                                      controller.dogwalkers[index].avaliacao!,
                                ),
                                leading: Visibility(
                                  visible:
                                      controller.dogwalkers[index].fotoUrl !=
                                              null
                                          ? true
                                          : false,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          controller.dogwalkers[index].fotoUrl!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: Text(
                                  "",
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
