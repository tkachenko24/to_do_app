import 'dart:async'; // Importing asynchronous utilities
import 'package:flex_color_scheme/flex_color_scheme.dart'; // Importing color scheme package
import 'package:flutter/cupertino.dart'; // Importing Flutter Cupertino widgets
import 'package:flutter/services.dart'; // Importing Flutter services
import 'package:provider/provider.dart'; // Importing Provider for state management

import 'injectable/export.dart'; // Importing dependency injection setup
import 'package:to_do_app/common/export.dart'; // Importing common utilities

import 'modules/export.dart'; // Importing app modules

Future<void> setup() async {
  final injector = Injector(
    // Initializing dependency injector
    injectable: [
      CommonInjectable(),
      DashboardInjectable(),
    ],
  );

  WidgetsFlutterBinding
      .ensureInitialized(); // Ensuring Flutter bindings are initialized

  await Future.wait([
    // Waiting for multiple asynchronous operations
    injector.setup(), // Setting up dependency injection
    SystemChrome.setPreferredOrientations([
      // Setting preferred screen orientations
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);

  final preferences = PreferencesBloc(
      (PreferencesState state) async {}); // Initializing preferences bloc

  final providers = [
    // List of providers for state management
    BlocProvider.value(value: preferences), // Providing preferences bloc
  ];

  preferences.add(
      const Initialization()); // Adding initialization event to preferences bloc

  runApp(
    MultiProvider(
      // Using MultiProvider for multiple providers
      providers: providers, // Providing list of providers
      child: Navigation(
        // Root widget for navigation
        builder: (
          context,
          routerDelegate,
          routeInformationParser,
          routeInformationProvider,
        ) {
          return MaterialApp.router(
            // Creating MaterialApp with router
            debugShowCheckedModeBanner: false, // Disabling debug banner
            themeMode: ThemeMode.light, // Setting light theme mode
            theme: FlexThemeData.light(
              // Setting light theme with FlexColorScheme
              useMaterial3: true, // Using Material 3 design
              scheme: FlexScheme.yellowM3, // Setting color scheme
              background: CupertinoColors
                  .lightBackgroundGray, // Setting background color
            ),
            routerDelegate: routerDelegate, // Providing router delegate
            routeInformationParser:
                routeInformationParser, // Providing route information parser
            routeInformationProvider:
                routeInformationProvider, // Providing route information provider
          );
        },
      ),
    ),
  );
}
