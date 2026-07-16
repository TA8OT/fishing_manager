import 'package:fishing_app/features/boats/presentation/screens/boat_form_screen.dart';
import 'package:fishing_app/features/boats/presentation/screens/boat_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:fishing_app/app/screens/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/boatform', builder: (context, state) => BoatFormScreen()),
    GoRoute(path: '/boats', builder: (context, state) => BoatListScreen()),
  ],
);
