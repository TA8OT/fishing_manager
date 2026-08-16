import 'package:fishing_app/features/boats/data/dtos/boat_owner_dto.dart';

class BoatOwnerState {
  final List<BoatOwnerDto> boatOwners;
  final double totalShare;
  final bool isLoading;
  final String? errorMessage;

  const BoatOwnerState({
    this.boatOwners = const [],
    this.totalShare = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  BoatOwnerState copyWith({
    List<BoatOwnerDto>? boatOwners,
    double? totalShare,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return BoatOwnerState(
      boatOwners: boatOwners ?? this.boatOwners,
      totalShare: totalShare ?? this.totalShare,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
