import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/workers/data/models/worker_model.dart';
import 'package:fishing_app/features/workers/data/repositories/worker_repository.dart';
import 'package:fishing_app/features/workers/presentation/providers/worker_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkerNotifier extends Notifier<WorkerState> {
  late final WorkerRepository repository;

  @override
  WorkerState build() {
    repository = WorkerRepository(AppDatabase.instance);
    Future.microtask(() => loadWorkers());

    return WorkerState(workers: [], isLoading: false);
  }

  Future<void> loadWorkers() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await repository.getAllWorkers();

      state = state.copyWith(
        workers: result,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> addWorker(WorkerModel worker) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.insertWorker(worker);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
    await loadWorkers();
  }

  Future<void> updateWorker(WorkerModel worker) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.updateWorker(worker);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadWorkers();
  }

  Future<void> deleteWorker(int id) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.deleteWorker(id);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadWorkers();
  }
}
