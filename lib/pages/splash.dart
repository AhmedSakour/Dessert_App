import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/constant/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  bool showProgressIndicator = false;
  @override
  void initState() {
    initAnimation();

    goToHome();
    Timer(const Duration(seconds: 5), () {
      setState(() {
        showProgressIndicator = true;
      });
    });
    super.initState();
  }

  void goToHome() {
    Future.delayed(
      const Duration(seconds: 7),
      () {
        try {
          Navigator.pushNamed(context, 'Nav');
        } on Exception catch (e) {
          print(e);
        }
      },
    );
  }

  void initAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    slideAnimation = Tween<Offset>(begin: Offset(0, 10), end: Offset(0, 0))
        .animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assest/images/SKG.jpg',
                width: 200,
                height: 200,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: slideAnimation,
            builder: (context, _) {
              return SlideTransition(
                position: slideAnimation,
                child: Text(
                  'Welcome',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'poppins'),
                ),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          if (showProgressIndicator) CircularProgressIndicator()
        ],
      ),
    );
  }
}
