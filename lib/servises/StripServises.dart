import 'dart:developer';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery/constant/app_keys.dart';
import 'package:food_delivery/servises/sharedPref.dart';
import '../models/ehtmeralModel.dart';
import '../models/paymentIntentInputModel.dart';
import '../models/paymentIntentModel.dart';

import 'ApiServises.dart';

class StripServices {
  static bool done = false;
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var data = await ApiServices().post(
        url: AppKeys.paymentIntentKey,
        body: paymentIntentInputModel.jsonto(),
        token: AppKeys.secretKey);
    return PaymentIntentModel.fromJson(data);
  }

  Future intentPaymentSheet({
    required String paymentIntentClientSecret,
    required String ephemeralKeySecret,
    required String custId,
  }) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      customerEphemeralKeySecret: ephemeralKeySecret,
      customerId: custId,
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: 'Ahmad Sakour',
    ));
  }

  Future displayPaymeentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      done = true;
    } on Exception {
      done = false;
      print('paymnet cancel');
    }
  }

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var epthmeralmodel = await createEphemeral(paymentIntentInputModel);
    String? id = await SharedPrefHelper().getUserId();
    await intentPaymentSheet(
        custId: id!,
        ephemeralKeySecret: epthmeralmodel.secret!,
        paymentIntentClientSecret: paymentIntentModel.clientSecret!);

    await displayPaymeentSheet();
  }

  Future<PaymentIntentModel> createCostumer(
      {required String id, required String name}) async {
    var data = await ApiServices().post(
        url: AppKeys.costumerKey,
        body: {
          'name': name,
          'id': id,
        },
        token: AppKeys.secretKey);
    return PaymentIntentModel.fromJson(data);
  }

  Future<EpthmeralModel> createEphemeral(
      PaymentIntentInputModel paymentIntentInputModel) async {
    String? id = await SharedPrefHelper().getUserId();
    log(id.toString());
    var data = await ApiServices().post(
        url: AppKeys.ephemeralKey,
        body: {'customer': id},
        headers: {
          'Authorization': 'Bearer ${AppKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Stripe-Version': '2023-10-16'
        },
        token: AppKeys.secretKey);
    return EpthmeralModel.fromJson(data);
  }
}
