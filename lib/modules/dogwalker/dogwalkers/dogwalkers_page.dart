import 'package:flutter/material.dart';
import 'package:tutor/modules/dogwalker/dogwalkers_list/dogwalkers_list_widget.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

class DogwalkersPage extends StatefulWidget {
  const DogwalkersPage({Key? key}) : super(key: key);

  @override
  _DogwalkersPageState createState() => _DogwalkersPageState();
}

class _DogwalkersPageState extends State<DogwalkersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Column(
        children: [
          TitlePageWidget(
            title: "Dog walkers",
          ),
          DogwalkersListWidget(),
        ],
      ),
    );
  }
}
