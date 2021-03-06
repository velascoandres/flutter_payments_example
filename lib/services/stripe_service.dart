import 'package:dio/dio.dart';
import 'package:flutter_payments_example/models/payment_intent_response.dart';
import 'package:flutter_payments_example/models/stripe_custom_response.dart';
import 'package:meta/meta.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Singleton

  StripeService._privateConstructor();

  static final StripeService _instance = StripeService._privateConstructor();

  factory StripeService() => _instance;

  // API KEYS
  String publishableKey = '<TODO: Poner el respectivo key>';
  static String _secretKey = '<TODO: Poner el respectivo key>';

  String _paymentUrl = 'https://api.stripe.com/v1/payment_intents';

  final headersOptions = new Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {'Authorization': 'Bearer $_secretKey'});

  void init() {
    final options = StripeOptions(
        publishableKey: this.publishableKey,
        androidPayMode: 'test',
        merchantId: 'test');
    StripePayment.setOptions(options);
  }

  Future<StripeCustomResponse> pagarConNuevaTarjeta({
    @required String amount,
    @required String currency,
  }) async {
    try {
      final cardForm = CardFormPaymentRequest();

      final paymentMethod =
          await StripePayment.paymentRequestWithCardForm(cardForm);

      final respuestaPago = await this._realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );

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

  Future<StripeCustomResponse> pagarConTarjetaExistente({
    @required String amount,
    @required String currency,
    @required CreditCard card,
  }) async {
    try {
      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card),
      );

      final respuestaPago = await this._realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );

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

  Future<StripeCustomResponse> pagarApplePayGooglePay({
    @required String amount,
    @required String currency,
  }) async {
    try {
      final newAmount = double.parse(amount) / 100;

      final token = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
          currencyCode: currency,
          totalPrice: amount,
        ),
        applePayOptions: ApplePayPaymentOptions(
          countryCode: 'US',
          currencyCode: currency,
          items: [
            ApplePayItem(
              label: 'Super producto',
              amount: newAmount.toString(),
            ),
          ],
        ),
      );

      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
            card: CreditCard(
          token: token.tokenId,
        )),
      );

      final respuestaPago = await this._realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );
      // cerrar modal de pago
      StripePayment.completeNativePayRequest();
      return respuestaPago;
      
    } catch (e) {
      print('Error en el intento : ${e.toString()}');
      return StripeCustomResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }

  Future<PaymentIntentResponse> _createPaymentIntent({
    @required String amount,
    @required String currency,
  }) async {
    try {
      final dio = new Dio();
      final data = {
        'amount': amount,
        'currency': currency,
      };

      final response = await dio.post(
        this._paymentUrl,
        data: data,
        options: headersOptions,
      );

      return PaymentIntentResponse.fromJson(response.data);
    } catch (e) {
      print('Error en intento: ${e.toString()}');

      return PaymentIntentResponse(
        status: '400',
      );
    }
  }

  Future _realizarPago({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod,
  }) async {
    try {
      final paymentIntent = await this._createPaymentIntent(
        amount: amount,
        currency: currency,
      );

      final paymentResult = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent.clientSecret,
          paymentMethodId: paymentMethod.id,
        ),
      );

      if (paymentResult.status == 'succeeded') {
        return StripeCustomResponse(ok: true, msg: 'Pago realizado');
      } else {
        return StripeCustomResponse(
            ok: false, msg: 'Fallo: ${paymentResult.status}');
      }
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }
}
