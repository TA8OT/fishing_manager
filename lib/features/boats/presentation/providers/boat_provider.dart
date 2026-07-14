import 'package:fishing_app/features/boats/presentation/providers/boat_notifier.dart';
import 'package:fishing_app/features/boats/presentation/providers/boat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final boatProvider = NotifierProvider<BoatNotifier, BoatState>(
  BoatNotifier.new,
);
