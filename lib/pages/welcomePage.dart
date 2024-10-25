import 'package:flutter/material.dart';
import 'package:food_delivery/constant/app_styles.dart';
import 'package:food_delivery/constant/app_colors.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String> images = [
    'assest/images/img1.png',
    'assest/images/img3.png',
    'assest/images/img2.png'
  ];

  List<String> title = [
    'Select From Our Best Menu ',
    'Easy and Online Payment',
    'Quick Delivery at Your Doorstep'
  ];

  List<String> subtitle = [
    'Pick Your Sweets From Our Menu \n  With Delicious taste ',
    'You Can Pay Cash on Delivery and  \n Card Payment is available ',
    'Freshly made desserts delivered directly to you, so you can indulge without leaving home.\n'
  ];

  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  int currentinde = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              currentinde = value;
            });
          },
          controller: pageController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        images[index],
                        height: 400,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(title[index], style: AppStyles.style20),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      subtitle[index],
                      style: AppStyles.style15,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 10,
                      margin: EdgeInsets.only(left: 170),
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, indexs) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 2),
                              width: indexs == index ? 30 : 8,
                              height: 2,
                              decoration: BoxDecoration(
                                  color: indexs == index
                                      ? AppColor.mainColorOpacity
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                width: 2,
                              ),
                          itemCount: 3),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (currentinde == images.length - 1) {
                          Navigator.pushReplacementNamed(context, 'Login');
                        }
                        pageController.nextPage(
                            duration: Duration(microseconds: 500),
                            curve: Curves.bounceIn);
                      },
                      child: Container(
                        width: 300,
                        height: 60,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  left: 270,
                  top: 10,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'Login');
                      },
                      child: Text(
                        'Skip',
                        style: AppStyles.style20Purple,
                      )),
                )
              ],
            );
          },
        )));
  }
}
