import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/boats/data/repositories/boat_repository.dart';
import 'package:fishing_app/features/boats/presentation/providers/boat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fishing_app/features/boats/data/models/boat_model.dart';

class BoatNotifier extends Notifier<BoatState> {
  late final BoatRepository repository;
  @override
  BoatState build() {
    repository = BoatRepository(AppDatabase.instance);
    Future.microtask(() => loadBoats());

    return BoatState(boats: [], isLoading: false);
  }

  Future<void> loadBoats() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await repository.getAllBoats();
      state = state.copyWith(
        boats: result,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> addBoat(BoatModel boat) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.insertBoat(boat);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    await loadBoats();
  }

  Future<void> updateBoat(BoatModel boat) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.updateBoat(boat);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    await loadBoats();
  }

  Future<void> deleteBoat(int id) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.deleteBoat(id);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    await loadBoats();
  }
}
