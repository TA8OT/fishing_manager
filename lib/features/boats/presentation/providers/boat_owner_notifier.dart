import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/boats/data/models/boat_owner_model.dart';
import 'package:fishing_app/features/boats/data/repositories/boat_owner_repository.dart';
import 'package:fishing_app/features/boats/presentation/providers/boat_owner_state.dart';

class BoatOwnerNotifier extends Notifier<BoatOwnerState> {
  late final BoatOwnerRepository repository;

  @override
  BoatOwnerState build() {
    repository = BoatOwnerRepository(AppDatabase.instance);

    return const BoatOwnerState();
  }

  Future<void> loadBoatOwners(int boatId) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final boatOwners = await repository.getBoatOwnersWithDetails(boatId);

      final totalShare = await repository.getTotalShareByBoatId(boatId);

      state = state.copyWith(
        boatOwners: boatOwners,
        totalShare: totalShare,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> addBoatOwner(BoatOwnerModel boatOwner) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await repository.insertBoatOwner(boatOwner);

      await loadBoatOwners(boatOwner.boatId);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());

      return false;
    }
  }

  Future<bool> updateBoatOwner(BoatOwnerModel boatOwner) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await repository.updateBoatOwner(boatOwner);

      await loadBoatOwners(boatOwner.boatId);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());

      return false;
    }
  }

  Future<bool> deleteBoatOwner(BoatOwnerModel boatOwner) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await repository.deleteBoatOwner(boatOwner.id!);

      await loadBoatOwners(boatOwner.boatId);

      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());

      return false;
    }
  }

  Future<bool> hasCompleteOwnerShares(int boatId) async {
    try {
      return await repository.hasCompleteOwnerShares(boatId);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());

      return false;
    }
  }
}
