import 'package:fishing_app/features/boats/data/models/boat_model.dart';
import 'package:fishing_app/features/boats/presentation/screens/boat_form_screen.dart';
import 'package:fishing_app/features/boats/presentation/screens/boat_list_screen.dart';
import 'package:fishing_app/features/expenses/data/models/expense_model.dart';
import 'package:fishing_app/features/expenses/presentation/screens/expense_form_screen.dart';
import 'package:fishing_app/features/expenses/presentation/screens/expense_list_screen.dart';
import 'package:fishing_app/features/fishs/data/models/fish_model.dart';
import 'package:fishing_app/features/fishs/presentation/screens/fish_form_screen.dart';
import 'package:fishing_app/features/fishs/presentation/screens/fish_list_screen.dart';
import 'package:fishing_app/features/owners/data/models/owner_model.dart';
import 'package:fishing_app/features/owners/presentation/screens/owner_form_screen.dart';
import 'package:fishing_app/features/owners/presentation/screens/owner_list_screen.dart';
import 'package:fishing_app/features/workers/data/models/worker_model.dart';
import 'package:fishing_app/features/workers/presentation/screens/worker_form_screen.dart';
import 'package:fishing_app/features/workers/presentation/screens/worker_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:fishing_app/app/screens/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),

    GoRoute(path: '/boats', builder: (context, state) => BoatListScreen()),
    GoRoute(
      path: '/boatform',
      builder: (context, state) {
        final boat = state.extra as BoatModel?;

        return BoatFormScreen(boat: boat);
      },
    ),

    GoRoute(path: '/workers', builder: (context, state) => WorkerListScreen()),
    GoRoute(
      path: '/workerform',
      builder: (context, state) {
        final worker = state.extra as WorkerModel?;

        return WorkerFormScreen(worker: worker);
      },
    ),

    GoRoute(path: '/owners', builder: (context, state) => OwnerListScreen()),
    GoRoute(
      path: '/ownerform',
      builder: (context, state) {
        final owner = state.extra as OwnerModel?;

        return OwnerFormScreen(owner: owner);
      },
    ),

    GoRoute(path: '/fishs', builder: (context, state) => FishListScreen()),
    GoRoute(
      path: '/fishform',
      builder: (context, state) {
        final fish = state.extra as FishModel?;

        return FishFormScreen(fish: fish);
      },
    ),

    GoRoute(
      path: '/expenses',
      builder: (context, state) => ExpenseListScreen(),
    ),
    GoRoute(
      path: '/expenseform',
      builder: (context, state) {
        final expense = state.extra as ExpenseModel?;

        return ExpenseFormScreen(expense: expense);
      },
    ),
  ],
);
