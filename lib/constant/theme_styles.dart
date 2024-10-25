import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../servises/theme_cubit/theme_cubit.dart';

class ThemeSelector {
  static ThemeData getTheme(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final state = themeCubit.state;

    return (state is DarkTheme) ? ThemeDataStyle.dark : ThemeDataStyle.light;
  }
}

class ThemeDataStyle {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Colors.white,
        primary: Colors.black,
        secondary: Colors.white),
  );

  static ThemeData dark = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Color(0xFF131842),
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF131842),
      ),
      colorScheme: ColorScheme.dark(
        background: Color(0xFF131842),
        primary: Colors.white,
        secondary: Colors.black,
      ));
}
