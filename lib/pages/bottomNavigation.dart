import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/constant/app_colors.dart';
import 'package:food_delivery/pages/HomePage.dart';
import 'package:food_delivery/pages/profile.dart';
import 'package:food_delivery/pages/wallet.dart';
import 'package:food_delivery/servises/check_internet_cubit/check_internet_cubit.dart';

import '../servises/delete_user_account_cubit/delete_user_account_cubit.dart';
import '../widgets/no_internet.dart';
import 'order.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

List pages = [
  HomePage(),
  OrderPage(),
  WalletPage(),
  ProfilePage(),
];

class _BottomNavState extends State<BottomNav> {
  int currentindex = 0;

  @override
  void initState() {
    currentindex = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteUserAccountCubit>(
      create: (context) => DeleteUserAccountCubit(),
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            backgroundColor: Colors.transparent,
            color: AppColor.mainColor,
            animationDuration: Duration(milliseconds: 500),
            onTap: (value) {
              setState(() {
                currentindex = value;
              });
            },
            items: const [
              Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
              Icon(
                Icons.wallet_outlined,
                color: Colors.white,
              ),
              Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
            ]),
        body: BlocBuilder<CheckInternetCubit, CheckInternetState>(
          builder: (context, state) {
            if (state is InternetStateSuccess) {
              return pages[currentindex];
            } else if (state is InternetStateFailure) {
              return NoInternet();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
