import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_payments_example/bloc/pagar/pagar_bloc.dart';
import 'package:flutter_payments_example/mocks/tarjetas_credito_mock.dart';
import 'package:flutter_payments_example/widgets/total_pay_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TarjetaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            final pagarBloc = context.read<PagarBloc>();
            pagarBloc.add(OnDesactivarTarjeta());
            Navigator.of(context).pop(); // 
          },
        ),
      ),
      body: Stack(
        children: [
          Container(),
          Hero(
            tag: tarjetas[0].cardNumber,
            child: CreditCardWidget(
              cardNumber: tarjetas[0].cardNumber,
              expiryDate: tarjetas[0].expiracyDate,
              cardHolderName: tarjetas[0].cardHolderName,
              cvvCode: tarjetas[0].cvv,
              showBackView: false,
            ),
          ),
          Positioned(
            bottom: 0,
            child: TotalPayButton(),
          )
        ],
      ),
    );
  }
}
