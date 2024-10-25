import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/constant/app_colors.dart';
import 'package:food_delivery/servises/StripServises.dart';
import 'package:food_delivery/widgets/custom_text_field.dart';

import '../servises/save_user_data_local_cubit/save_user_data_local_cubit.dart';
import '../servises/save_user_data_remote_cubit/save_user_data_remote_cubit.dart';
import '../servises/viewed_user_all_item_sweets_cubit/viewed_user_all_item_sweets_cubit.dart';
import '../widgets/showSnack.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  String? name, password, eamil;
  TextEditingController emailcontrolller = TextEditingController();
  TextEditingController passwordcontrolller = TextEditingController();
  TextEditingController namecontrolller = TextEditingController();
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
                          'Sign',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins'),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomTextField(
                            hint: 'Name',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.black,
                            ),
                            textInputType: TextInputType.name,
                            textEditingController: namecontrolller),
                        SizedBox(
                          height: 30.0,
                        ),
                        CustomTextField(
                            hint: 'Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                            textInputType: TextInputType.emailAddress,
                            textEditingController: emailcontrolller),
                        SizedBox(
                          height: 30.0,
                        ),
                        CustomTextField(
                            hint: 'Password',
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.black,
                            ),
                            textInputType: TextInputType.visiblePassword,
                            obscureText: true,
                            textEditingController: passwordcontrolller),
                        SizedBox(
                          height: 45,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (fromkey.currentState!.validate()) {
                              setState(() {
                                eamil = emailcontrolller.text;
                                name = namecontrolller.text;
                                password = passwordcontrolller.text;
                              });

                              registers(context);
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
                                'SIGN UP',
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
                  'ALready have an account ?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      fontSize: 17),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'login',
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

  void registers(BuildContext context) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: eamil!,
        password: password!,
      );
      FirebaseAuth auth = FirebaseAuth.instance;

      String userId = auth.currentUser!.uid;
      String imageProfile =
          'https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg';
      Map<String, dynamic> userInfo = {
        'Id': userId,
        'Name': namecontrolller.text,
        'Email': emailcontrolller.text,
        'Wallet': 0,
        'Image': imageProfile,
        'Password': passwordcontrolller.text,
      };

      await signMethodes(
        userInfo,
        userId,
      );
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          'Nav',
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'weak password', c: AppColor.failureColor);
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'email exists', c: AppColor.failureColor);
      }
    } catch (e) {
      showSnackBar(context, 'error', c: AppColor.failureColor);
    }
  }

  Future<void> signMethodes(
    Map<String, dynamic> userInfo,
    String userId,
  ) async {
    final saveUserDataRemoteCubit =
        BlocProvider.of<SaveUserDataRemoteCubit>(context);
    final saveUserDataToSharedPreferenceCubit =
        BlocProvider.of<SaveUserDataToSharedPreferenceCubit>(context);
    final viewedUserAllSingleItemSweetsCubit =
        BlocProvider.of<ViewedUserAllItemSweetsCubit>(context);
    await saveUserDataRemoteCubit.adduserDetail(userInfo, userId);
    await saveUserDataToSharedPreferenceCubit.saveUserData();
    await viewedUserAllSingleItemSweetsCubit.viewedUserAllSweetsItems();

    await StripServices()
        .createCostumer(id: userId, name: namecontrolller.text);
  }
}
