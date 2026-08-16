import 'package:fishing_app/features/boats/presentation/providers/boat_owner_notifier.dart';
import 'package:fishing_app/features/boats/presentation/providers/boat_owner_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final boatOwnerProvider = NotifierProvider<BoatOwnerNotifier, BoatOwnerState>(
  BoatOwnerNotifier.new,
);
