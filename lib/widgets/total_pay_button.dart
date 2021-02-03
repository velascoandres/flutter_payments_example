import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_payments_example/bloc/pagar/pagar_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                '250.55 USD',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          BlocBuilder<PagarBloc, PagarState>(
            builder: (context, state) {
              return _BtnPay(pagarState: state,);
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
      onPressed: () {},
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
    );
  }

  Widget buildPayTarjeta(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      elevation: 0,
      shape: StadiumBorder(),
      onPressed: () {},
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
    );
  }
}
