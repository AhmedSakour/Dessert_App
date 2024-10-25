import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery/constant/app_routes.dart';
import 'package:food_delivery/servises/bloc_observer.dart';
import 'package:food_delivery/servises/check_auth.dart';
import 'package:food_delivery/servises/check_internet_cubit/check_internet_cubit.dart';
import 'package:food_delivery/servises/get_dessert_cubit/get_dessert_cubit.dart';

import 'package:food_delivery/servises/local_notification.dart';
import 'package:food_delivery/servises/order_cubit/order_cubit.dart';

import 'package:food_delivery/servises/theme_cubit/theme_cubit.dart';
import 'package:food_delivery/servises/update_user_wallet_cubit/update_user_wallet_cubit.dart';

import 'package:food_delivery/servises/upload_user_photo_cubit/upload_user_photo_cubit.dart';
import 'constant/app_keys.dart';
import 'constant/theme_styles.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = AppKeys.publishKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  LocalNotification.initalize(flutterLocalNotificationsPlugin);
  runApp(MultiBlocProvider(providers: [
    BlocProvider<OrderCubit>(
      create: (context) => OrderCubit(),
    ),
    BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit()..loadTheme(),
    ),
    BlocProvider<CheckInternetCubit>(
      create: (context) => CheckInternetCubit()..checkInternet(),
    ),
    BlocProvider<GetDessertCubit>(
      create: (context) => GetDessertCubit(),
    ),
    BlocProvider<UpdateUserWalletCubit>(
      create: (context) => UpdateUserWalletCubit(),
    ),
    BlocProvider<UploadUserPhotoCubit>(
      create: (context) => UploadUserPhotoCubit()..getImageFromSharedPref(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: AppRoutes.getRoutes(),
      title: 'Flutter Demo',
      theme: ThemeSelector.getTheme(context),
      home: CheckAuthentication(),
    );
  }
}
