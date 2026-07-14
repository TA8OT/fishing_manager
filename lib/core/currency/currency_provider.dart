import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'currency.dart';
import 'currency_notifier.dart';

final currencyProvider = NotifierProvider<CurrencyNotifier, Currency>(
  CurrencyNotifier.new,
);
