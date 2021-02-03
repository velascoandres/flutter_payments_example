part of 'pagar_bloc.dart';

@immutable
class PagarState {
  final double montoPagar;
  final String moneda; // USD, CAD , EU
  final bool tarjetaActiva;
  final TarjetaCredito tarjeta;

  PagarState({
    this.montoPagar = 375.55,
    this.moneda = 'USD',
    this.tarjetaActiva = false,
    this.tarjeta,
  });

  PagarState copyWith({
    double montoPagar,
    String moneda, // USD, CAD , EU
    bool tarjetaActiva,
    TarjetaCredito tarjeta,
  }) => PagarState(
    moneda: moneda ?? this.moneda,
    tarjeta: tarjeta ?? this.tarjeta,
    tarjetaActiva: tarjetaActiva ?? this.tarjetaActiva,
    montoPagar: montoPagar ?? this.montoPagar,
    );
}
