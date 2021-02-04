import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_payments_example/bloc/pagar/pagar_bloc.dart';
import 'package:flutter_payments_example/helpers/helpers.dart';
import 'package:flutter_payments_example/mocks/tarjetas_credito_mock.dart';
import 'package:flutter_payments_example/pages/tarjeta_page.dart';
import 'package:flutter_payments_example/services/stripe_service.dart';
import 'package:flutter_payments_example/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  final StripeService stripeService = new StripeService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // ignore: close_sinks
    final pagarBloc = context.read<PagarBloc>();
    // asdasd
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagar'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final monto = pagarBloc.state.montoPagarString;
              final moneda = pagarBloc.state.moneda;

              mostrarLoading(context);
              final resp = await this.stripeService.pagarConNuevaTarjeta(
                    amount: monto,
                    currency: moneda,
                  );
              Navigator.pop(context);
              if (resp.ok) {
                mostrarAlerta(context, 'Notificación', 'Todo ha salido bien');
              } else {
                mostrarAlerta(context, 'Notificación', 'Algo salió mal');
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: 0.9,
              ),
              physics: BouncingScrollPhysics(),
              itemCount: tarjetas.length,
              itemBuilder: (_, i) {
                final tarjeta = tarjetas[i];
                return GestureDetector(
                  onTap: () {
                    pagarBloc.add(OnSeleccionarTarjeta(tarjeta));
                    Navigator.push(
                      context,
                      navegarFadeIn(
                        context,
                        TarjetaPage(),
                      ),
                    );
                  },
                  child: Hero(
                    tag: tarjeta.cardNumber,
                    child: CreditCardWidget(
                      cardNumber: tarjeta.cardNumber,
                      expiryDate: tarjeta.expiracyDate,
                      cardHolderName: tarjeta.cardHolderName,
                      cvvCode: tarjeta.cvv,
                      showBackView: false,
                    ),
                  ),
                );
              },
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
