// app_routes.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/pages/SignUp.dart';
import '../admin/adminHome.dart';
import '../admin/deleteHome.dart';
import '../pages/DetailPage.dart';
import '../pages/HomePage.dart';
import '../pages/bottomNavigation.dart';
import '../pages/forgetPassword.dart';
import '../pages/login.dart';

import '../pages/welcomePage.dart';

import '../admin/add_dessert.dart';
import '../pages/report_problem.dart';

import '../servises/add_dessert_photo_cubit/add_dessert_cubit.dart';
import '../servises/check_auth.dart';
import '../servises/save_user_data_local_cubit/save_user_data_local_cubit.dart';
import '../servises/save_user_data_remote_cubit/save_user_data_remote_cubit.dart';
import '../servises/viewed_user_all_item_sweets_cubit/viewed_user_all_item_sweets_cubit.dart';

class AppRoutes {
  static const login = 'Login';
  static const signUp = 'Sign';
  static const home = 'Home';
  static const nav = 'Nav';
  static const forgotPassword = 'Rec';
  static const detail = 'Detail';
  static const welcome = 'Welcome';
  static const adminHome = 'HomeAdmin';
  static const addDessert = 'AddDessert';
  static const homeDelete = 'HomeDelete';
  static const authWrapper = 'authWrapper';
  static const reportProblem = 'ContactUs';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<SaveUserDataToSharedPreferenceCubit>(
                create: (context) => SaveUserDataToSharedPreferenceCubit(),
              ),
              BlocProvider<ViewedUserAllItemSweetsCubit>(
                create: (context) => ViewedUserAllItemSweetsCubit(),
              ),
            ],
            child: LoginPage(),
          ),
      signUp: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<SaveUserDataToSharedPreferenceCubit>(
                create: (context) => SaveUserDataToSharedPreferenceCubit(),
              ),
              BlocProvider<SaveUserDataRemoteCubit>(
                create: (context) => SaveUserDataRemoteCubit(),
              ),
              BlocProvider<ViewedUserAllItemSweetsCubit>(
                create: (context) => ViewedUserAllItemSweetsCubit(),
              ),
            ],
            child: SignUP(),
          ),
      home: (context) => HomePage(),
      nav: (context) => BottomNav(),
      forgotPassword: (context) => ForgetPassword(),
      detail: (context) => DetailPage(),
      welcome: (context) => WelcomePage(),
      adminHome: (context) => AdminHome(),
      addDessert: (context) => BlocProvider<AddDessertCubit>(
            create: (context) => AddDessertCubit(),
            child: AddDessert(),
          ),
      homeDelete: (context) => HomeDelete(),
      authWrapper: (context) => CheckAuthentication(),
      reportProblem: (context) => ReportProblem(),
    };
  }
}
