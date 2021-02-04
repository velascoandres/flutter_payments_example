import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_payments_example/bloc/pagar/pagar_bloc.dart';
import 'package:flutter_payments_example/widgets/total_pay_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TarjetaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tarjeta = context.read<PagarBloc>().state.tarjeta;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pagar con: ${tarjeta.cardNumberHidden}...'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            // ignore: close_sinks
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
            tag: tarjeta.cardNumber,
            child: CreditCardWidget(
              cardNumber: tarjeta.cardNumber,
              expiryDate: tarjeta.expiracyDate,
              cardHolderName: tarjeta.cardHolderName,
              cvvCode: tarjeta.cvv,
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
