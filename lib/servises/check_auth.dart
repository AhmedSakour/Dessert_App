import 'package:flutter/material.dart';
import 'package:food_delivery/pages/splash.dart';
import 'package:food_delivery/pages/welcomePage.dart';
import 'package:food_delivery/servises/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckAuthentication extends StatefulWidget {
  const CheckAuthentication({super.key});

  @override
  State<CheckAuthentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<CheckAuthentication> {
  String? register;
  load() async {
    register = await SharedPrefHelper().getAuthRegister();

    setState(() {});
  }

  @override
  void initState() {
    load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot snapshot) {
        if (register == 'true') {
          return SplashPage();
        } else {
          return WelcomePage();
        }
      },
    );
  }
}
