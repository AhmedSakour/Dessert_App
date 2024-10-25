import 'package:flutter/material.dart';
import 'package:food_delivery/constant/app_colors.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Home Admin',
                  style: TextStyle(
                      color: AppColor.mainColor,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'AddDessert');
                },
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  child: Container(
                    width: 300,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.mainColor,
                    ),
                    child: Center(
                      child: Text(
                        'Add to Dessert Items',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'HomeDelete');
                },
                child: Material(
                  elevation: 10,
                  color: Colors.white,
                  child: Container(
                    width: 300,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.mainColor,
                    ),
                    child: Center(
                      child: Text(
                        'Delete item',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
