// ignore_for_file: implicit_call_tearoffs

import 'package:go_router/go_router.dart'; // Importing GoRouter for navigation

import 'package:to_do_app/common/export.dart'; // Importing common utilities

import 'guards/export.dart'; // Importing navigation guards
import 'screens/export.dart'; // Importing app screens
import 'notifiers/export.dart'; // Importing notifiers

typedef RoutingBuilder = Widget Function(
  BuildContext context,
  RouterDelegate<Object> routerDelegate,
  RouteInformationParser<Object> routeInformationParser,
  RouteInformationProvider routeInformationProvider,
);

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(); // Global key for navigator

class Navigation extends StatelessWidget {
  final RoutingBuilder builder;
  final List<Screens> screens = [
    // List of screens
    CommonScreens(),
    DashboardScreens(),
  ];

  Navigation({super.key, required this.builder}); // Constructor

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      // Initializing GoRouter
      debugLogDiagnostics: true, // Debugging diagnostics
      navigatorKey: navigatorKey, // Providing navigator key
      initialLocation: CommonScreens.splash.path, // Setting initial location
      refreshListenable: Listenable.merge([
        // Merging listenables for refresh
        BlocNotifier(context
            .read<PreferencesBloc>()), // Adding preferences bloc notifier
      ]),
      redirect: ScreenGuards([
        // Redirecting with guards
        BootstrapGuard(), // Guarding bootstrap process
      ]),
      routes:
          screens.expand((screen) => screen.routes).toList(), // Defining routes
      errorBuilder: (context, state) =>
          const UnknownScreen(), // Building error screen
    );

    return builder(
      // Returning built widget
      context,
      router.routerDelegate,
      router.routeInformationParser,
      router.routeInformationProvider,
    );
  }
}
