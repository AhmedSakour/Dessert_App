import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/constant/app_colors.dart';

import 'package:food_delivery/widgets/custom_text_field.dart';
import '../servises/save_user_data_local_cubit/save_user_data_local_cubit.dart';
import '../servises/viewed_user_all_item_sweets_cubit/viewed_user_all_item_sweets_cubit.dart';
import '../widgets/showSnack.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? password, email;

  TextEditingController emailcontrolller = TextEditingController();

  TextEditingController passwordcontrolller = TextEditingController();
  @override
  var fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(color: AppColor.mainColor),
          ),
          Container(
            margin: EdgeInsets.only(top: 260),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 110),
              child: Container(
                height: 450,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3),
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
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins'),
                        ),
                        SizedBox(
                          height: 40.0,
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
                          obscureText: true,
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.black,
                          ),
                          textEditingController: passwordcontrolller,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'Rec');
                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (fromkey.currentState!.validate()) {
                              setState(() {
                                email = emailcontrolller.text;

                                password = passwordcontrolller.text;
                              });
                              loginIn(context);

                              // setState(() {});
                            }
                          },
                          child: Container(
                            width: 200,
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
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 590),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account ?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      fontSize: 17),
                ),
                TextButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, 'Sign');
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: AppColor.mainColor,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }

  Future<void> loginIn(BuildContext context) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      await loginMethods();
      Future.delayed(Duration(milliseconds: 300),
          () => Navigator.pushNamed(context, 'Nav'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.',
            c: AppColor.failureColor);
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password', c: AppColor.failureColor);
      }
    }
  }

  Future<void> loginMethods() async {
    final saveUserDataToSharedPreferenceCubit =
        BlocProvider.of<SaveUserDataToSharedPreferenceCubit>(context);
    final viewedUserAllSingleItemSweetsCubit =
        BlocProvider.of<ViewedUserAllItemSweetsCubit>(context);
    await saveUserDataToSharedPreferenceCubit.saveUserData();

    await viewedUserAllSingleItemSweetsCubit.viewedUserAllSweetsItems();
  }
}
