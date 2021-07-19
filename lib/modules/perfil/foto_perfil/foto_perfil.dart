import 'package:flutter/material.dart';
import 'package:tutor/shared/themes/app_images.dart';

class FotoPerfil extends StatelessWidget {
  const FotoPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(AppImages.logoDogwalker),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 40,
              width: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Icon(Icons.camera_alt_outlined),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
