import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constant/theme_styles.dart';
import 'package:food_delivery/servises/sharedPref.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    initializeTheme();
  }

  ThemeData themeDataStyle = ThemeDataStyle.light;

  Future<void> initializeTheme() async {
    themeDataStyle = await loadTheme();
  }

  loadTheme() async {
    String? theme = await SharedPrefHelper().getUserTheme();
    if (theme == 'dark') {
      await SharedPrefHelper().saveTheme('dark');
      emit(DarkTheme());
      return ThemeDataStyle.dark;
    } else {
      await SharedPrefHelper().saveTheme('light');
      emit(LightTheme());
      return ThemeDataStyle.light;
    }
  }

  changeTheme() async {
    String? theme = await SharedPrefHelper().getUserTheme();

    themeDataStyle =
        theme == 'dark' ? ThemeDataStyle.dark : ThemeDataStyle.light;
    if (themeDataStyle == ThemeDataStyle.light) {
      themeDataStyle = ThemeDataStyle.dark;
      await SharedPrefHelper().saveTheme('dark');

      emit(DarkTheme());
    } else {
      themeDataStyle = ThemeDataStyle.light;
      await SharedPrefHelper().saveTheme('light');

      emit(LightTheme());
    }
  }
}
