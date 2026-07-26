import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/owners/data/models/owner_model.dart';
import 'package:fishing_app/features/owners/data/repositories/owner_repository.dart';
import 'package:fishing_app/features/owners/presentation/providers/owner_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerNotifier extends Notifier<OwnerState> {
  late final OwnerRepository repository;

  @override
  OwnerState build() {
    repository = OwnerRepository(AppDatabase.instance);
    Future.microtask(() => loadOwner());

    return OwnerState(owners: [], isLoading: false);
  }

  Future<void> loadOwner() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await repository.getAllOwner();

      state = state.copyWith(
        owners: result,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadOwner();
  }

  Future<void> addOwner(OwnerModel owner) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.updateOwner(owner);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    await loadOwner();
  }

  Future<void> updateOwner(OwnerModel owner) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.updateOwner(owner);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadOwner();
  }

  Future<void> deleteOwner(int id) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.deleteOwner(id);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadOwner();
  }
}
