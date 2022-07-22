import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/screens/home_page.dart';
import 'package:pokedex/theme/color_const.dart';
import 'package:pokedex/theme/text_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: MyColors.psychic,
          suffixIconColor: MyColors.psychic,
        ),
        appBarTheme: AppBarTheme(
            titleTextStyle:
                MyTextStyle.poppinsBold16.copyWith(color: MyColors.darkGray),
            iconTheme: const IconThemeData(
              color: MyColors.darkGray,
            ),
            color: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            )),
      ),
      home: const HomePage(),
    );
  }
}
