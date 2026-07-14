import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'currency.dart';

class CurrencyNotifier extends Notifier<Currency> {
  @override
  Currency build() {
    return Currency(code: 'USD', name: 'United States Dollar', symbol: '\$');
  }

  void changeCurrency(Currency currency) {
    state = currency;
  }
}
