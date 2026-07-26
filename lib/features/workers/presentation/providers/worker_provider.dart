import 'package:fishing_app/features/workers/presentation/providers/worker_notifier.dart';
import 'package:fishing_app/features/workers/presentation/providers/worker_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workerProvider = NotifierProvider<WorkerNotifier, WorkerState>(
  WorkerNotifier.new,
);
