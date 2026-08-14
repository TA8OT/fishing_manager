import 'package:fishing_app/features/trips/data/models/trip_model.dart';

class TripState {
  final List<TripModel> trips;
  final bool isLoading;
  final String? errorMessage;

  TripState({required this.trips, required this.isLoading, this.errorMessage});

  TripState copyWith({
    final List<TripModel>? trips,
    final bool? isLoading,
    final String? errorMessage,
  }) {
    return TripState(
      trips: trips ?? this.trips,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
