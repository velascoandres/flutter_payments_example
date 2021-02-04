import 'package:flutter/foundation.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Singleton

  StripeService._privateConstructor();

  static final StripeService _instance = StripeService._privateConstructor();

  factory StripeService() => _instance;

  String _publishedKey = 'pk_test_iAcplaq4fZ9jJ7coXZp3EhKB00L0fu04WZ';
  String _secretKey = 'sk_test_tCmRg9kSMYGt1JyONXYbO52s00y6yAl4SE';
  String _paymentUrl = 'https://api.stripe.com/v1/payment_intents';

  void init() {}

  Future pagarConTarjetaExistente({
    @required String amount,
    @required String currency,
    @required CreditCard card,
  }) async {}

  Future pagarConNuevaTarjeta({
    @required String amount,
    @required String currency,
  }) async {}

  Future pagarApplePayGooglePay({
    @required String amount,
    @required String currency,
  }) async {}

  Future _realizarPago({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod,
  }) async {}
}
