import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/fishs/data/models/fish_model.dart';
import 'package:fishing_app/features/fishs/data/repositories/fish_repository.dart';
import 'package:fishing_app/features/fishs/presentation/providers/fish_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishNotifier extends Notifier<FishState> {
  late final FishRepository repository;

  @override
  FishState build() {
    repository = FishRepository(AppDatabase.instance);

    Future.microtask(() => loadFishs());

    return FishState(fishs: [], isLoading: false);
  }

  Future<void> loadFishs() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await repository.getAllFishs();

      state = state.copyWith(
        fishs: result,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> addFish(FishModel fish) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.insertFish(fish);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadFishs();
  }

  Future<void> updateFish(FishModel fish) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.updateFish(fish);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadFishs();
  }

  Future<void> deleteFish(int id) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.deleteFish(id);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadFishs();
  }
}
