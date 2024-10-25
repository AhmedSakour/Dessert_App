import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:food_delivery/constant/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_buttom.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  final fromKey = GlobalKey<FormState>();

  final problemController = TextEditingController();
  bool isValidate = true;

  File? selectImage;
  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectImage = File(image.path);
    }
  }

  sendEmail({
    required body,
  }) async {
    Email email = Email(
        isHTML: false,
        body: body,
        recipients: ['hussian0938605821@gmail.com'],
        subject: 'Dessert App',
        attachmentPaths: selectImage != null ? [selectImage!.path] : []);
    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    Color containerColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, left: 70),
                    child: Row(
                      children: [
                        Transform.rotate(
                          angle: 0.1,
                          child: Icon(
                            Icons.message,
                            color: Colors.grey,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Transform.rotate(
                          angle: 0.4,
                          child: Icon(
                            Icons.message,
                            color: AppColor.mainColor,
                            size: 80,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Contacy Us',
                    style: TextStyle(fontSize: 32, fontFamily: 'poppins'),
                  ),
                  Text(
                    'And tell us what your problem',
                    style: TextStyle(fontSize: 18, fontFamily: 'poppins'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: Color(0xFFececf8),
                        boxShadow: [
                          isValidate
                              ? BoxShadow()
                              : BoxShadow(
                                  color: AppColor.mainColor,
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: problemController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              isValidate = false;
                            });
                            return 'Please Enter the problem';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter the problem',
                          hintStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontFamily: 'poppins'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'you can Attach a picture of the problem :',
                    style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  selectImage == null
                      ? GestureDetector(
                          onTap: () async {
                            await getImage();
                            setState(() {});
                          },
                          child: Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              color: containerColor,
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [BoxShadow(blurRadius: 3)],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            await getImage();
                            setState(() {});
                          },
                          child: Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [BoxShadow(blurRadius: 3)],
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  selectImage!,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        if (fromKey.currentState!.validate()) {
                          await sendEmail(
                            body: problemController.text,
                          );
                        }
                      },
                      child: CustomButton(
                        data: 'send',
                        sizeData: 20,
                        color: AppColor.mainColor,
                        height: 40,
                        width: 200,
                        radius: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
