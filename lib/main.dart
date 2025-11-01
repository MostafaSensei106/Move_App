import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move_app/core/cache/hive_cache_adapters.dart';
import 'package:move_app/core/di/dependency_injection.dart';
import 'package:move_app/core/helpers/shared_pref_helper.dart';
import 'package:move_app/core/routing/app_router.dart';
import 'package:move_app/core/routing/routes.dart';
import 'package:move_app/core/theme/theme_data/dark_them_data.dart';
import 'package:move_app/core/theme/theme_data/light_theme_data.dart';
import 'package:move_app/core/theme/theme_manager/theme_cubit.dart';
import 'package:move_app/features/details/data/cache/movie_details_cache_service.dart';
import 'package:move_app/features/home/data/cache/movies_cache_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// The main entry point of the application.
Future<void> main() async {
  // Ensure that the Flutter binding is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure that screen utilities are set up before the UI is built.
  await ScreenUtil.ensureScreenSize();

  // Initialize application-level services.
  await SharedPrefHelper.init(); // For storing simple key-value data.
  await initGetIt(); // For dependency injection.
  await HiveCacheAdapters.init(); // For local database (Hive) type adapters.
  await MoviesCacheService.init(); // For caching movie lists.
  await MovieDetailsCacheService.init(); // For caching movie details.

  // Set the system UI mode to immersive, hiding system bars.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  // Customize the system UI overlay style.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // Initialize Sentry for error reporting, but only in non-debug mode.
  if (!kDebugMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://b70be1b821613139d05c59d78a256f11@o4510283114086400.ingest.us.sentry.io/4510283118673920';
        options.sendDefaultPii =
            true; // Send personally identifiable information.
      },
      // Run the app within the Sentry scope.
      appRunner: () => runApp(
        // Use DevicePreview for testing responsiveness in debug mode.
        DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => MyApp(appRouter: AppRouter()),
        ),
      ),
    );
  } else {
    // In debug mode, run the app without Sentry.
    runApp(
      DevicePreview(
        enabled: false, // DevicePreview can be enabled here for debugging.
        builder: (context) => MyApp(appRouter: AppRouter()),
      ),
    );
  }
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  /// The router for the application.
  final AppRouter appRouter;

  /// Creates a [MyApp] instance.
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive UI design.
    return ScreenUtilInit(
      designSize: const Size(428, 926), // The design screen size.
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        // Provide the ThemeCubit to the widget tree.
        return BlocProvider(
          create: (_) => ThemeCubit(),
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, newMode) {
              // The main MaterialApp widget.
              return MaterialApp(
                debugShowCheckedModeBanner: false,

                // Set the light and dark themes.
                theme: getLightTheme(context),
                darkTheme: getDarkTheme(context),
                themeMode: newMode, // The current theme mode.
                // Set up the app's routing.
                onGenerateRoute: appRouter.generateRoute,
                initialRoute: Routes.homeScreen,
              );
            },
          ),
        );
      },
    );
  }
}
