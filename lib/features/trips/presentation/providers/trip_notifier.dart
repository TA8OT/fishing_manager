import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/trips/data/models/trip_model.dart';
import 'package:fishing_app/features/trips/data/repositories/trip_repository.dart';
import 'package:fishing_app/features/trips/presentation/providers/trip_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';

class TripNotifier extends Notifier<TripState> {
  late final TripRepository repository;

  @override
  TripState build() {
    repository = TripRepository(AppDatabase.instance);
    Future.microtask(() => loadTrips());

    return TripState(trips: [], isLoading: false);
  }

  Future<void> loadTrips() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await repository.getAllTrip();

      state = state.copyWith(
        trips: result,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> addTrip(TripModel trip) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.insertTrip(trip);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadTrips();
  }

  Future<void> updateTrip(TripModel trip) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.updateTrip(trip);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }

    await loadTrips();
  }

  Future<void> deleteTrip(int id) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.deleteTrip(id);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }

    await loadTrips();
  }
}
