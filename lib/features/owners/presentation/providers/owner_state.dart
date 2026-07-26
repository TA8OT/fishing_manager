import 'package:fishing_app/features/owners/data/models/owner_model.dart';

class OwnerState {
  final List<OwnerModel> owners;
  final bool isLoading;
  final String? errorMessage;

  OwnerState({
    required this.owners,
    required this.isLoading,
    this.errorMessage,
  });

  OwnerState copyWith({
    final List<OwnerModel>? owners,
    final bool? isLoading,
    final String? errorMessage,
  }) {
    return OwnerState(
      owners: owners ?? this.owners,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
