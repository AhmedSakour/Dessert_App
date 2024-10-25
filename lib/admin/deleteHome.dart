import 'package:flutter/material.dart';
import 'package:food_delivery/admin/deletItemPage.dart';
import 'package:food_delivery/constant/app_colors.dart';

class HomeDelete extends StatelessWidget {
  HomeDelete({super.key});
  List images = [
    'assest/images/cake.png',
    'assest/images/ice-cream.png',
    'assest/images/pie.png',
    'assest/images/cookie.png',
  ];

  List item = [
    'Cake',
    'Ice-cream',
    'Pie',
    'Cookies',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Select category',
                  style: TextStyle(
                      color: AppColor.mainColor,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (100 / 150),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  padding: EdgeInsets.all(18.0),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DeleteItemPage(sweetName: item[index]);
                          },
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Image.asset(
                              images[index],
                              color: Colors.white,
                              width: 100,
                              height: 150,
                            ),
                            Text(
                              item[index],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
