import 'package:fishing_app/features/boats/data/models/boat_model.dart';

class BoatState {
  final List<BoatModel> boats;
  final bool isLoading;
  final String? errorMessage;

  BoatState({required this.boats, required this.isLoading, this.errorMessage});

  BoatState copyWith({
    final List<BoatModel>? boats,
    final bool? isLoading,
    final String? errorMessage,
  }) {
    return BoatState(
      boats: boats ?? this.boats,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
