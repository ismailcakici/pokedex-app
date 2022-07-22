import 'package:flutter/material.dart';

import '../theme/color_const.dart';
import '../theme/text_style.dart';
import 'background_color_map.dart';

class PokeCard extends StatelessWidget {
  final int? id;
  final String? theNum;
  final String? name;
  final String? img;
  final Color backgroundColor;
  final List<String?>? type;
  const PokeCard(
      {Key? key,
      this.id,
      this.theNum,
      this.name,
      this.img,
      this.type,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Card(
      elevation: 8,
      shadowColor:
          MyBackgroundColorMap.myTypeColors[type?[0].toString().toLowerCase()],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(width: 3, color: MyColors.background),
      ),
      color:
          MyBackgroundColorMap.myTypeColors[type?[0].toString().toLowerCase()],
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "#${theNum!}",
            style: MyTextStyle.poppinsRegular10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topRight,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(40 / 360),
              child: Image.asset(
                "assets/pokeball.png",
                height: height / 8,
                color: MyColors.background.withOpacity(0.2),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: Image.network(img!)),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  height: height / 16,
                  color: MyColors.white,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      name!,
                      style: MyTextStyle.poppinsBold14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
