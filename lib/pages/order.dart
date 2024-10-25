import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/constant/app_colors.dart';
import 'package:food_delivery/models/orderModel.dart';
import 'package:food_delivery/servises/order_cubit/order_cubit.dart';
import 'package:food_delivery/servises/sharedPref.dart';
import 'package:food_delivery/servises/update_user_wallet_cubit/update_user_wallet_cubit.dart';
import 'package:food_delivery/widgets/cartBody.dart';
import 'package:food_delivery/widgets/custom_result_dialog.dart';

import '../widgets/custom_confirm_dialog.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String? id;

  String? wallet;
  int newWallet = 0;

  int amount = 0;
  int totalAmount = 0;
  getUserInfo() async {
    id = await SharedPrefHelper().getUserId();
    wallet = await SharedPrefHelper().getUserWallet();
    setState(() {});
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return id == null
        ? const Center(child: CircularProgressIndicator())
        : BlocProvider<OrderCubit>(
            create: (context) => OrderCubit()..getCart(id: id!),
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Dessert Cart',
                    style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 25,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                body: BlocConsumer<OrderCubit, OrderState>(
                  listener: (context, state) {
                    if (state is OrderDeleteSuccess) {
                      BlocProvider.of<OrderCubit>(context).getCart(id: id!);
                    }
                  },
                  builder: (context, state) {
                    if (state is OrderGetSucces) {
                      List<OrderModel>? data =
                          BlocProvider.of<OrderCubit>(context).orderModel;
                      amount =
                          (BlocProvider.of<OrderCubit>(context).totalPrice ??
                              0);
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 330,
                              child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    OrderModel item = data[index];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: CardItem(
                                          onRemove: () {
                                            try {
                                              customConfirmDilogo(context,
                                                  height: 170,
                                                  data:
                                                      'Are you sure you want to delete the item from order? ',
                                                  ontap1: () {
                                                Navigator.pop(context);
                                              }, ontap2: () async {
                                                Navigator.pop(context);
                                                await BlocProvider.of<
                                                        OrderCubit>(context)
                                                    .deletOrder(index, id!);
                                              },
                                                  dataButton1: 'No',
                                                  dataButton2: 'Yes');
                                            } on Exception {
                                              customResultDilogo(context,
                                                  data: 'There\'s a error',
                                                  dataButton: 'ok',
                                                  icon: Icons.error, ontap: () {
                                                Navigator.pop(context);
                                              }, colorIcon: Colors.red);
                                            }
                                          },
                                          quantity: item.amount,
                                          image: item.image,
                                          name: item.title,
                                          total: item.price),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 20,
                                      ),
                                  itemCount: data!.length),
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                children: [
                                  Divider(
                                    thickness: 3,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Price ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            fontFamily: 'poppins'),
                                      ),
                                      Text(
                                        '$amount\$',
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'poppins'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (int.parse(wallet!) >= amount) {
                                        customResultDilogo(context,
                                            height: 151,
                                            iconSize: 30,
                                            data: 'successfully payment',
                                            dataButton: 'ok',
                                            icon: Icons.check_circle,
                                            ontap: () async {
                                          Navigator.pop(context);

                                          await BlocProvider.of<OrderCubit>(
                                                  context)
                                              .getCart(id: id!);
                                        }, colorIcon: Colors.green);
                                        final currentContext = context;
                                        await BlocProvider.of<OrderCubit>(
                                                context)
                                            .deleteCart(id!);
                                        newWallet = int.parse(wallet!) - amount;
                                        if (mounted) {
                                          await BlocProvider.of<
                                                      UpdateUserWalletCubit>(
                                                  currentContext)
                                              .updateUserWallet(
                                                  id!, '$newWallet');
                                        }
                                      } else {
                                        customResultDilogo(context,
                                            data:
                                                'You don\'t have enough money',
                                            dataButton: 'close',
                                            height: 171, ontap: () {
                                          Navigator.pop(context);
                                        }, colorIcon: AppColor.failureColor);
                                      }
                                    },
                                    child: Container(
                                      width: 300,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: AppColor.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          'checkout',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is OrderGetLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is OrderGetError) {
                      return Center(
                          child: Text(
                        'No order',
                        style: TextStyle(fontSize: 25, fontFamily: 'poppins'),
                      ));
                    } else {
                      return Container();
                    }
                  },
                )),
          );
  }
}
