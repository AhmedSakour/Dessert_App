import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constant/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/showSnack.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({super.key});

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  String? password, email;

  TextEditingController emailcontrolller = TextEditingController();

  TextEditingController passwordcontrolller = TextEditingController();

  var fromkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 400),
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(110),
                      topRight: Radius.circular(110)),
                  color: AppColor.mainColor,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: Text(
                  'let\'s Start with Admin',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 400,
                width: 350,
                margin: EdgeInsets.only(top: 150, left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: Form(
                    key: fromkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          hint: 'Email',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
                          textEditingController: emailcontrolller,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        CustomTextField(
                          hint: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          textEditingController: passwordcontrolller,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (fromkey.currentState!.validate()) {
                              setState(() {
                                email = emailcontrolller.text;

                                password = passwordcontrolller.text;
                              });
                              adminLogin();
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                'LOGIN',
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  adminLogin() {
    FirebaseFirestore.instance.collection('Admin').get().then((snapshot) {
      for (var element in snapshot.docs) {
        if (element.data()['id'] != emailcontrolller.text.trim()) {
          showSnackBar(context, 'Your Name is not correct', c: Colors.black);
        } else if (element.data()['password'] !=
            passwordcontrolller.text.trim()) {
          showSnackBar(context, 'Your password is not correct',
              c: Colors.black);
        } else {
          Navigator.pushNamed(context, 'HomeAdmin');
        }
      }
    });
  }
}
