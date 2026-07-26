import 'package:fishing_app/features/owners/presentation/providers/owner_notifier.dart';
import 'package:fishing_app/features/owners/presentation/providers/owner_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ownerProvider = NotifierProvider<OwnerNotifier, OwnerState>(
  OwnerNotifier.new,
);
