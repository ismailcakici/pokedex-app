import 'package:flutter/material.dart';
import 'package:pokedex/model/poke_model.dart';
import 'package:pokedex/theme/color_const.dart';
import 'package:pokedex/theme/text_style.dart';

class DetailPage extends StatelessWidget {
  final int? id;
  final String? theNum;
  final String? name;
  final String? img;
  final List<String?>? type;
  final String? height;
  final String? weight;
  final String? candy;
  final int? candyCount;
  final String? egg;
  final double? spawnChance;
  final int? avgSpawns;
  final String? spawnTime;
  final List<double?>? multipliers;
  final List<String?>? weaknesses;
  final List<PokeModelPokemonNextEvolution?>? nextEvolution;
  final Color? backgroundColor;
  const DetailPage(
      {Key? key,
      required this.name,
      this.id,
      this.theNum,
      this.img,
      this.type,
      this.height,
      this.weight,
      this.candy,
      this.candyCount,
      this.egg,
      this.spawnChance,
      this.avgSpawns,
      this.spawnTime,
      this.multipliers,
      this.weaknesses,
      this.nextEvolution,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height2 = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(40 / 360),
              child: Image.asset(
                "assets/pokeball.png",
                color: MyColors.background.withOpacity(0.2),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: width,
                  height: height2 / 1.5,
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      box(height2),
                      chip(),
                      stats(height2),
                      statCandy(),
                      statSpawn(),
                      statWeaknesses(),
                      statMultiple(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            heightFactor: 2.5,
            child: Image.network(
              img!,
            ),
          ),
        ],
      ),
    );
  }

  Padding statMultiple() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Multipliers: ",
            style: MyTextStyle.poppinsBold16,
          ),
          Text(
            multipliers![0].toString(),
            style: MyTextStyle.poppinsRegular16,
          ),
        ],
      ),
    );
  }

  Padding statWeaknesses() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Weakness : ",
            style: MyTextStyle.poppinsBold16,
          ),
          Text(
            weaknesses![0]!,
            style: MyTextStyle.poppinsRegular16,
          ),
        ],
      ),
    );
  }

  Padding statSpawn() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Avg Spawns : ",
            style: MyTextStyle.poppinsBold16,
          ),
          Text(
            avgSpawns!.toString(),
            style: MyTextStyle.poppinsRegular16,
          ),
        ],
      ),
    );
  }

  Padding statCandy() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Candy : ",
            style: MyTextStyle.poppinsBold16,
          ),
          Text(
            candy!,
            style: MyTextStyle.poppinsRegular16,
          ),
        ],
      ),
    );
  }

  Padding chip() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Chip(
          label: Text(
            type![0]!,
            style: MyTextStyle.poppinsRegular16,
          ),
          backgroundColor: backgroundColor),
    );
  }

  SizedBox box(double height2) {
    return SizedBox(
      height: height2 / 15,
    );
  }

  IntrinsicHeight stats(double height2) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset("assets/weight_icon.png"),
                Text(
                  "Weight",
                  style: MyTextStyle.poppinsBold16,
                ),
                Text(
                  weight!,
                  style: MyTextStyle.poppinsRegular16,
                )
              ],
            ),
            const VerticalDivider(
              thickness: 1,
              endIndent: 70,
              color: MyColors.medGray,
            ),
            Column(
              children: [
                Image.asset("assets/height_icon.png"),
                Text(
                  "Height",
                  style: MyTextStyle.poppinsBold16,
                ),
                Text(
                  height!,
                  style: MyTextStyle.poppinsRegular16,
                )
              ],
            ),
            const VerticalDivider(
              thickness: 1,
              endIndent: 70,
              color: MyColors.medGray,
            ),
            Column(
              children: [
                Icon(
                  Icons.numbers,
                  color: MyColors.medGray,
                  size: height2 / 40,
                ),
                Text(
                  "Number",
                  style: MyTextStyle.poppinsBold16,
                ),
                Text(
                  theNum!,
                  style: MyTextStyle.poppinsRegular16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        name!,
        style: MyTextStyle.poppinsBold24,
      ),
    );
  }
}
