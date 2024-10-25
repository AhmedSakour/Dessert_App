import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constant/app_colors.dart';
import 'package:food_delivery/widgets/custom_text_field.dart';
import 'package:food_delivery/widgets/showSnack.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String? email;
  var fromkey = GlobalKey<FormState>();
  TextEditingController emailcont = TextEditingController();
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      showSnackBar(context, 'Password Reset Email has been sent !',
          c: Colors.grey);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showSnackBar(context, 'No user found for that email.', c: Colors.grey);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Password Recovery',
                      style: TextStyle(
                          color: AppColor.mainColor,
                          fontFamily: 'poppins',
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'Enter your email',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'poppins',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: fromkey,
                    child: CustomTextField(
                        hint: 'Email',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        textInputType: TextInputType.emailAddress,
                        textEditingController: emailcont),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (fromkey.currentState!.validate()) {
                        setState(() {
                          email = emailcont.text;
                        });
                        resetPassword();
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: 400,
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Send Email',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'poppins',
                            fontSize: 17),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'Sign');
                        },
                        child: Text(
                          'Create',
                          style: TextStyle(
                              color: AppColor.mainColor,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
