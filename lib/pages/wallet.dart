import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/constant/app_colors.dart';
import 'package:food_delivery/servises/StripServises.dart';
import 'package:food_delivery/servises/sharedPref.dart';
import 'package:food_delivery/servises/update_user_wallet_cubit/update_user_wallet_cubit.dart';
import '../models/paymentIntentInputModel.dart';

class WalletPage extends StatefulWidget {
  TextEditingController moneyController = TextEditingController();
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String? wallet;
  String? id;
  int? add;

  var fromkey = GlobalKey<FormState>();

  List<String> money = [
    '100',
    '500',
    '1000',
    '2000',
  ];
  getUserInfo() async {
    wallet = await SharedPrefHelper().getUserWallet();
    id = await SharedPrefHelper().getUserId();
    setState(() {});
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  void dispose() {
    widget.moneyController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Wallet',
                  style: TextStyle(
                      color: AppColor.mainColor,
                      fontSize: 25,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: double.infinity,
                height: 5,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[300],
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assest/images/wallet.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your Wallet',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$ $wallet',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add money',
                      style: TextStyle(
                          fontFamily: 'poppins', fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                PaymentIntentInputModel
                                    paymentIntentInputModel =
                                    PaymentIntentInputModel(
                                  customerId: id,
                                  amount: money[index],
                                  currency: 'USD',
                                );
                                try {
                                  await StripServices().makePayment(
                                      paymentIntentInputModel:
                                          paymentIntentInputModel);
                                  if (StripServices.done) {
                                    final currentContext = context;
                                    add = int.parse(money[index]) +
                                        int.parse(wallet!);
                                    if (mounted) {
                                      await BlocProvider.of<
                                                  UpdateUserWalletCubit>(
                                              currentContext)
                                          .updateUserWallet(id!, '$add');
                                      await getUserInfo();
                                    }
                                  }
                                } on Exception {}
                              },
                              child: Container(
                                width: 70,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '\$${money[index]}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                width: 10,
                              ),
                          itemCount: 4),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            content: SingleChildScrollView(
                              child: SizedBox(
                                width: 300,
                                height: 250,
                                child: Form(
                                  key: fromkey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.cancel),
                                          ),
                                          SizedBox(
                                            width: 90,
                                          ),
                                          Text(
                                            'Add Money',
                                            style: TextStyle(
                                              color: AppColor.mainColor,
                                              fontFamily: 'poppins',
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: widget.moneyController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter amount';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          hintText: 'Enter the Amount',
                                          hintStyle:
                                              TextStyle(fontFamily: 'poppins'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (fromkey.currentState!
                                                .validate()) {
                                              PaymentIntentInputModel
                                                  paymentIntentInputModel =
                                                  PaymentIntentInputModel(
                                                      customerId: id,
                                                      amount: widget
                                                          .moneyController.text,
                                                      currency: 'USD');
                                              await StripServices().makePayment(
                                                  paymentIntentInputModel:
                                                      paymentIntentInputModel);
                                              add = int.parse(widget
                                                      .moneyController.text) +
                                                  int.parse(wallet!);

                                              if (mounted) {
                                                Navigator.pop(currentContext);
                                                await BlocProvider.of<
                                                            UpdateUserWalletCubit>(
                                                        currentContext)
                                                    .updateUserWallet(
                                                        id!, '$add');
                                                await getUserInfo();
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: AppColor.mainColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Center(
                                              child: Text(
                                                'pay',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'poppins'),
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
                          ),
                        );
                      },
                      child: Container(
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Add money',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
