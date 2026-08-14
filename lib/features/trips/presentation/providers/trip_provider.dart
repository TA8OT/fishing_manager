import 'package:fishing_app/features/trips/presentation/providers/trip_notifier.dart';
import 'package:fishing_app/features/trips/presentation/providers/trip_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tripProvider = NotifierProvider<TripNotifier, TripState>(
  TripNotifier.new,
);
