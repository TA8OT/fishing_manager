import 'package:fishing_app/features/workers/data/models/worker_model.dart';

class WorkerState {
  final List<WorkerModel> workers;
  final bool isLoading;
  final String? errorMessage;

  WorkerState({
    required this.workers,
    required this.isLoading,
    this.errorMessage,
  });

  WorkerState copyWith({
    final List<WorkerModel>? workers,
    final bool? isLoading,
    final String? errorMessage,
  }) {
    return WorkerState(
      workers: workers ?? this.workers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
