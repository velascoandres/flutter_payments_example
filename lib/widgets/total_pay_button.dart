import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_payments_example/bloc/pagar/pagar_bloc.dart';
import 'package:flutter_payments_example/helpers/helpers.dart';
import 'package:flutter_payments_example/services/stripe_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final pagarBloc = BlocProvider.of<PagarBloc>(context);

    return Container(
      height: 100,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${pagarBloc.state.montoPagar} ${pagarBloc.state.moneda}',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          BlocBuilder<PagarBloc, PagarState>(
            builder: (context, state) {
              return _BtnPay(
                pagarState: state,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BtnPay extends StatelessWidget {
  final PagarState pagarState;

  const _BtnPay({this.pagarState});

  @override
  Widget build(BuildContext context) {
    if (pagarState.tarjetaActiva) {
      return buildPayTarjeta(context);
    }
    return buildAppleAndGooglePay(context);
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      elevation: 0,
      shape: StadiumBorder(),
      color: Colors.black,
      child: Row(
        children: [
          Icon(
              Platform.isAndroid
                  ? FontAwesomeIcons.googlePay
                  : FontAwesomeIcons.applePay,
              color: Colors.white),
          SizedBox(
            width: 20,
          ),
          Text('Pagar', style: TextStyle(color: Colors.white, fontSize: 22)),
        ],
      ),
      onPressed: () async {
       await this._establecerPagoGooglePay(context);
      },
    );
  }

  Widget buildPayTarjeta(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      elevation: 0,
      shape: StadiumBorder(),
      color: Colors.black,
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.solidCreditCard,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Text('Pagar', style: TextStyle(color: Colors.white, fontSize: 22)),
        ],
      ),
      onPressed: () async {
        await _establecerPagoTarjeta(context);
      },
    );
  }

  Future _establecerPagoTarjeta(BuildContext context) async {
    mostrarLoading(context);

    final stripeService = new StripeService();
    final state = context.read<PagarBloc>().state;
    final tarjeta = state.tarjeta;
    final monto = state.montoPagarString;
    final moneda = state.moneda;

    final mesAnio = tarjeta.expiracyDate.split('/');

    final mes = int.parse(mesAnio[0]);
    final anio = int.parse(mesAnio[1]);

    final response = await stripeService.pagarConTarjetaExistente(
      amount: monto,
      currency: moneda,
      card: CreditCard(
        number: tarjeta.cardNumber,
        expMonth: mes,
        expYear: anio,
        cvc: tarjeta.cvv,
      ),
    );

    Navigator.pop(context);
    if (response.ok) {
      mostrarAlerta(context, 'Notificación', 'Todo ha salido bien');
    } else {
      mostrarAlerta(context, 'Notificación', 'Algo salió mal');
    }
  }

  Future _establecerPagoGooglePay(BuildContext context) async {
    mostrarLoading(context);

    final stripeService = new StripeService();
    final state = context.read<PagarBloc>().state;
    final monto = state.montoPagarString;
    final moneda = state.moneda;

    final response = await stripeService.pagarApplePayGooglePay(
      amount: monto,
      currency: moneda,
    );

    Navigator.pop(context);
    if (response.ok) {
      mostrarAlerta(context, 'Notificación', 'Todo ha salido bien');
    } else {
      mostrarAlerta(context, 'Notificación', 'Algo salió mal');
    }
  }
}
