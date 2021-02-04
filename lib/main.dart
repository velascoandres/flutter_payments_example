import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_payments_example/bloc/pagar/pagar_bloc.dart';
import 'package:flutter_payments_example/pages/home_page.dart';
import 'package:flutter_payments_example/pages/pago_completo_page.dart';
import 'package:flutter_payments_example/services/stripe_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    new StripeService() ..init();
    
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PagarBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Stripe App',
        initialRoute: 'home',
        debugShowCheckedModeBanner: false,
        routes: {
          'home': (_) => HomePage(),
          'pago_completo': (_) => PagoCompletoPage(),
        },
        theme: ThemeData.light().copyWith(
          primaryColor: Color(0xff284879),
          scaffoldBackgroundColor: Color(0xff21232A),
        ),
      ),
    );
  }
}
