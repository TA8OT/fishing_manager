import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/boats/data/repositories/boat_repository.dart';
import 'package:fishing_app/features/boats/presentation/providers/boat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fishing_app/features/boats/data/models/boat_model.dart';

class BoatNotifier extends Notifier<BoatState> {
  late final BoatRepository repository;
  @override
  build() {
    repository = BoatRepository(AppDatabase.instance);

    return BoatState(boats: [], isLoading: false);
  }

  Future<void> loadBoats() async {
    state.copyWith(isLoading: true);

    try {
      final result = await repository.getAllBoats();
      state.copyWith(boats: result);
    } catch (e) {
      state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    state.copyWith(isLoading: false);
  }

  Future<void> addBoat(BoatModel boat) async {
    state.copyWith(isLoading: true);

    try {
      await repository.insertBoat(boat);
    } catch (e) {
      state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    await loadBoats();
  }

  Future<void> updateBoat(BoatModel boat) async {
    state.copyWith(isLoading: true);

    try {
      await repository.updateBoat(boat);
    } catch (e) {
      state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    await loadBoats();
  }

  Future<void> deleteBoat(int id) async {
    state.copyWith(isLoading: true);

    try {
      await repository.deleteBoat(id);
    } catch (e) {
      state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    await loadBoats();
  }
}
