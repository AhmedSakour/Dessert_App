class PaymentIntentInputModel {
  var amount;
  var currency;
  var customerId;
  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
    required this.customerId,
  });
  jsonto() {
    return {
      'amount': '${amount}00',
      'currency': currency,
      'customer': customerId
    };
  }
}
