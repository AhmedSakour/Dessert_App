import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/constant/app_colors.dart';
import 'package:food_delivery/models/dessertModel.dart';
import 'package:food_delivery/servises/add_item_to_user_cart_cubit/add_item_to_user_cart_cubit.dart';
import 'package:food_delivery/servises/check_internet_cubit/check_internet_cubit.dart';
import 'package:food_delivery/servises/sharedPref.dart';
import 'package:food_delivery/widgets/custom_text_field.dart';
import 'package:food_delivery/widgets/no_internet.dart';
import '../widgets/custom_result_dialog.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

int x = 0;
int total = 0;

class _DetailPageState extends State<DetailPage> {
  String? id;

  getUserId() async {
    id = await SharedPrefHelper().getUserId();
  }

  var fromKey = GlobalKey<FormState>();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    getUserId();
    x = 0;
    total = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DessertModel dessertModel =
        ModalRoute.of(context)!.settings.arguments as DessertModel;
    return BlocProvider<AddItemToUserCartCubit>(
      create: (context) => AddItemToUserCartCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              )),
        ),
        body: BlocBuilder<CheckInternetCubit, CheckInternetState>(
          builder: (context, state) {
            if (state is InternetStateSuccess) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Form(
                    key: fromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: dessertModel.image,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            placeholder: (context, url) => Center(
                              child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator()),
                            ),
                            width: 300,
                            height: 300,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    dessertModel.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: AppColor.mainColor,
                                        fontFamily: 'poppins'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            SizedBox(
                              width: 110,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (x >= 1) {
                                        --x;
                                        total = total -
                                            int.parse(dessertModel.price);

                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: AppColor.mainColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ),
                                  Text(
                                    '$x',
                                    style: TextStyle(
                                        fontSize: 22, fontFamily: 'poppins'),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ++x;
                                      total =
                                          total + int.parse(dessertModel.price);
                                      setState(() {});
                                    },
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: AppColor.mainColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 130,
                          child: Text(
                            dessertModel.description,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontFamily: 'poppins'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                            hint: 'Enter your location',
                            prefixIcon: Icon(
                              Icons.location_on,
                            ),
                            textInputType: TextInputType.text,
                            textEditingController: locationController),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Price',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'poppins'),
                                ),
                                Text(
                                  '\$ ${total.toString()}',
                                  style: TextStyle(
                                      fontSize: 22, fontFamily: 'poppins'),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (fromKey.currentState!.validate()) {
                                  if (total != 0) {
                                    Map<String, dynamic> userCart = {
                                      'Name': dessertModel.name,
                                      'Image': dessertModel.image,
                                      'Quantity': x.toString(),
                                      'Price': dessertModel.price,
                                      'Location': locationController.text,
                                    };
                                    try {
                                      final currentContext = context;
                                      await BlocProvider.of<
                                              AddItemToUserCartCubit>(context)
                                          .adduserCart(userCart, id!);
                                      if (mounted) {
                                        customResultDilogo(currentContext,
                                            data:
                                                'The item was added successfully',
                                            dataButton: 'ok',
                                            icon: Icons.check_circle,
                                            ontap: () async {
                                          Navigator.pop(context);
                                        }, colorIcon: Colors.green);
                                      }
                                    } on Exception {
                                      // TODO
                                    }
                                  } else {
                                    customResultDilogo(
                                      context,
                                      icon: Icons.error_outline,
                                      iconSize: 40,
                                      colorIcon:
                                          Color.fromARGB(255, 235, 29, 15),
                                      data: 'No specific quantity',
                                      dataButton: 'ok',
                                      ontap: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  }
                                }
                              },
                              child: Container(
                                  width: 200,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Add to Cart',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'poppins'),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFD895DA),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.shopping_cart_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return NoInternet();
            }
          },
        ),
      ),
    );
  }
}
