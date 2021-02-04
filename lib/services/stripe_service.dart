import 'package:flutter_payments_example/models/stripe_custom_response.dart';
import 'package:meta/meta.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Singleton

  StripeService._privateConstructor();

  static final StripeService _instance = StripeService._privateConstructor();

  factory StripeService() => _instance;

  String publishableKey = 'pk_test_iAcplaq4fZ9jJ7coXZp3EhKB00L0fu04WZ';
  String _secretKey = 'sk_test_tCmRg9kSMYGt1JyONXYbO52s00y6yAl4SE';
  String _paymentUrl = 'https://api.stripe.com/v1/payment_intents';

  void init() {
    final options = StripeOptions(
        publishableKey: this.publishableKey,
        androidPayMode: 'test',
        merchantId: 'test');
    StripePayment.setOptions(options);
  }

  Future<StripeCustomResponse> pagarConTarjetaExistente({
    @required String amount,
    @required String currency,
    @required CreditCard card,
  }) async {
    try {
      
      final cardForm = CardFormPaymentRequest(

      );

      final paymentMethod =  await StripePayment.paymentRequestWithCardForm(

      );

      // TODO: Crear el intent

      return StripeCustomResponse(
        ok: true,
        msg: 'Todo ok',
      );

    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }

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
