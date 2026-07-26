import 'package:fishing_app/features/boats/data/models/boat_model.dart';
import 'package:fishing_app/features/boats/presentation/screens/boat_form_screen.dart';
import 'package:fishing_app/features/boats/presentation/screens/boat_list_screen.dart';
import 'package:fishing_app/features/workers/data/models/worker_model.dart';
import 'package:fishing_app/features/workers/presentation/screens/worker_form_screen.dart';
import 'package:fishing_app/features/workers/presentation/screens/worker_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:fishing_app/app/screens/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/boatform',
      builder: (context, state) {
        final boat = state.extra as BoatModel?;

        return BoatFormScreen(boat: boat);
      },
    ),
    GoRoute(path: '/boats', builder: (context, state) => BoatListScreen()),

    GoRoute(path: '/workers', builder: (context, state) => WorkerListScreen()),
    GoRoute(
      path: '/workerform',
      builder: (context, state) {
        final worker = state.extra as WorkerModel?;

        return WorkerFormScreen(worker: worker);
      },
    ),
  ],
);
