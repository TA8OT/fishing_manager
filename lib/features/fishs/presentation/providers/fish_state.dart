import 'package:fishing_app/features/fishs/data/models/fish_model.dart';

class FishState {
  final List<FishModel> fishs;
  final bool isLoading;
  final String? errorMessage;

  FishState({required this.fishs, required this.isLoading, this.errorMessage});

  FishState copyWith({
    final List<FishModel>? fishs,
    final bool? isLoading,
    final String? errorMessage,
  }) {
    return FishState(
      fishs: fishs ?? this.fishs,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
