import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/constant/app_colors.dart';
import 'package:food_delivery/models/dessertModel.dart';
import 'package:food_delivery/servises/add_dessert_photo_cubit/add_dessert_cubit.dart';
import 'package:random_string/random_string.dart';

import '../servises/notification_firebase.dart';
import '../widgets/custom_result_dialog.dart';

class AddDessert extends StatefulWidget {
  const AddDessert({super.key});

  @override
  State<AddDessert> createState() => _AddDessertState();
}

class _AddDessertState extends State<AddDessert> {
  String? value;
  String? name, price, detail;
  final List<String> itemfood = [
    'Cake',
    'Pie',
    'Cookies',
    'Ice-cream',
  ];
  double h1 = 50;
  double h2 = 50;
  TextEditingController namecont = TextEditingController();
  TextEditingController pricecont = TextEditingController();
  TextEditingController detailcont = TextEditingController();
  var fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Add Item',
            style: TextStyle(
                color: AppColor.mainColor,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF373866),
              ))),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: fromkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload the Item Picture',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<AddDessertCubit, AddDessertStates>(
                  builder: (context, state) {
                    if (state is GetDessertPhotoSuccess &&
                        BlocProvider.of<AddDessertCubit>(context).selectImage !=
                            null) {
                      return GestureDetector(
                        onTap: () async {
                          await BlocProvider.of<AddDessertCubit>(context)
                              .getImage();
                        },
                        child: Center(
                          child: Container(
                              width: 150,
                              height: 150,
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
                                  BlocProvider.of<AddDessertCubit>(context)
                                      .selectImage!,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () async {
                          await BlocProvider.of<AddDessertCubit>(context)
                              .getImage();
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [BoxShadow(blurRadius: 3)],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Item Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: h1,
                  decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 17, left: 20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: namecont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            h1 = 80;
                          });
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Item Name',
                        hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontFamily: 'poppins'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Item Price',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: h2,
                  decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7, left: 20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: pricecont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            h2 = 80;
                          });
                          return 'Please Enter Price';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Item Price',
                        hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontFamily: 'poppins'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Item Detail',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 160,
                  decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: detailcont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Detail';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Item Detail',
                        hintStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontFamily: 'poppins'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Select Category',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7, left: 20, right: 20),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: itemfood
                            .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                )))
                            .toList(),
                        dropdownColor: Colors.white,
                        hint: Text(
                          "Select Category",
                          style: TextStyle(color: Colors.black54),
                        ),
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                            // checkInternet();
                          });
                        },
                        value: value,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final currentContext = context;
                      if (fromkey.currentState!.validate() &&
                          value != null &&
                          BlocProvider.of<AddDessertCubit>(context)
                                  .selectImage !=
                              null) {
                        DessertModel dessertModel = DessertModel(
                            id: randomAlphaNumeric(10),
                            image: '',
                            viewedBy: [],
                            price: pricecont.text,
                            description: detailcont.text,
                            name: namecont.text);
                        try {
                          await BlocProvider.of<AddDessertCubit>(context)
                              .addDessert(value!, dessertModel, context);
                          await NotificationFirebase().sendFCMMessage();
                          if (mounted) {
                            customResultDilogo(currentContext,
                                data: 'The item was added successfully',
                                dataButton: 'ok',
                                icon: Icons.check_circle, ontap: () {
                              Navigator.pushNamed(context, 'HomeAdmin');
                            }, colorIcon: Colors.green);
                          }
                        } on Exception {}
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColor.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Add',
                          style: TextStyle(
                              fontFamily: 'poppins', color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
