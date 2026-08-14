import 'package:fishing_app/features/fishs/presentation/providers/fish_notifier.dart';
import 'package:fishing_app/features/fishs/presentation/providers/fish_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fishProvider = NotifierProvider<FishNotifier, FishState>(
  FishNotifier.new,
);
