import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pokedex/model/poke_model.dart' show PokeModelPokemon, PokeModel;
import 'package:pokedex/screens/detail_page.dart';
import 'package:pokedex/theme/color_const.dart';
import 'package:pokedex/theme/text_style.dart';
import 'package:pokedex/widgets/background_color_map.dart';
import 'package:pokedex/widgets/poke_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late bool isLoading;
  bool searchActive = false;
  PokeModel? pokeModel;
  late AnimationController animationController;

  @override
  void initState() {
    isLoading = true;
    super.initState();
    _getDataFromApi();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  void _getDataFromApi() async {
    var response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"));
    setState(() {
      pokeModel = PokeModel.fromJson(json.decode(response.body));
      isLoading = false;
    });
  }

  void iconTapped() {
    setState(() {
      if (searchActive == true) {
        animationController.forward();
        searchActive = false;
      } else {
        animationController.reverse();
        searchActive = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pokemon = pokeModel?.pokemon;
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            Visibility(visible: !searchActive, child: searchBar(context)),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: pokemon?.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 3.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: MyBackgroundColorMap.myTypeColors[
                        pokemon?[index]?.type?[0].toString().toLowerCase()],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              backgroundColor:
                                  MyBackgroundColorMap.myTypeColors[
                                      pokemon?[index]
                                          ?.type?[0]
                                          .toString()
                                          .toLowerCase()],
                              name: "${pokemon?[index]?.name}",
                              avgSpawns: pokemon?[index]?.avgSpawns,
                              height: pokemon?[index]?.height,
                              weight: pokemon?[index]?.weight,
                              type: [pokemon?[index]?.type?[0]],
                              candy: pokemon?[index]?.candy,
                              candyCount: pokemon?[index]?.candyCount,
                              egg: pokemon?[index]?.egg,
                              theNum: pokemon?[index]?.theNum,
                              img: pokemon?[index]?.img,
                              nextEvolution: [
                                pokemon?[index]?.nextEvolution?[0]
                              ],
                              multipliers: [pokemon?[index]?.multipliers?[0]],
                              weaknesses: [pokemon?[index]?.weaknesses?[0]],
                            ),
                          ));
                    },
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: MyBackgroundColorMap.myTypeColors[
                                  pokemon?[index]
                                      ?.type?[0]
                                      .toString()
                                      .toLowerCase()],
                            ),
                          )
                        : PokeCard(
                            backgroundColor: MyBackgroundColorMap.myTypeColors[
                                pokemon?[index]
                                    ?.type?[0]
                                    .toString()
                                    .toLowerCase()],
                            id: pokemon?[index]?.id,
                            img: pokemon?[index]?.img,
                            name: pokemon?[index]?.name,
                            theNum: pokemon?[index]?.theNum,
                            type: [pokemon?[index]?.type?[0]],
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: iconTapped,
              child: AnimatedIcon(
                  icon: AnimatedIcons.search_ellipsis,
                  progress: animationController),
            ),
          ),
        ),
      ],
      title: Text(
        "Pokédex",
        style: MyTextStyle.poppinsBold24.copyWith(color: MyColors.darkGray),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Lottie.network(
            "https://assets1.lottiefiles.com/packages/lf20_iwmd6pyr.json"),
      ),
    );
  }

  Autocomplete<PokeModelPokemon> searchBar(BuildContext context) {
    return Autocomplete<PokeModelPokemon>(
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) {
          return List.empty();
        }
        return pokeModel!.pokemon!
            .where((element) =>
                element!.name!.toLowerCase().contains(value.text.toLowerCase()))
            .toList()
            .whereType();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
              FocusNode node, Function onSubmit) =>
          Padding(
        padding: const EdgeInsets.all(18.0),
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: MyColors.psychic)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: MyColors.psychic)),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  controller.clear();
                });
              },
              icon: const Icon(Icons.clear),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: "Search Pokémon...",
          ),
          controller: controller,
          focusNode: node,
          style: MyTextStyle.poppinsBold14,
        ),
      ),
      optionsViewBuilder: (BuildContext context, Function onSelect,
          Iterable<PokeModelPokemon> pokeList) {
        return Material(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: pokeList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 3.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (BuildContext context, index) {
              PokeModelPokemon poke = pokeList.elementAt(index);
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: MyBackgroundColorMap
                    .myTypeColors[poke.type?[0].toString().toLowerCase()],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                            backgroundColor: MyBackgroundColorMap.myTypeColors[
                                poke.type?[0].toString().toLowerCase()],
                            name: poke.name,
                            avgSpawns: poke.avgSpawns,
                            height: poke.height,
                            weight: poke.weight,
                            type: [poke.type?[0]],
                            candy: poke.candy,
                            candyCount: poke.candyCount,
                            egg: poke.egg,
                            theNum: poke.theNum,
                            img: poke.img,
                            nextEvolution: [poke.nextEvolution?[0]],
                            multipliers: [poke.multipliers?[0]],
                            weaknesses: [poke.weaknesses?[0]]),
                      ));
                },
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MyBackgroundColorMap.myTypeColors[
                              poke.type?[0].toString().toLowerCase()],
                        ),
                      )
                    : PokeCard(
                        backgroundColor: MyBackgroundColorMap.myTypeColors[
                            poke.type?[0].toString().toLowerCase()],
                        id: poke.id,
                        img: poke.img,
                        name: poke.name,
                        theNum: poke.theNum,
                        type: [poke.type?[0]],
                      ),
              );
            },
          ),
        );
      },

      optionsMaxHeight: MediaQuery.of(context).size.height,
      //displayStringForOption: (PokeModelPokemon d) => d.name!,
    );
  }
}
