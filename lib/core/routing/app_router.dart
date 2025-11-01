import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/core/di/dependency_injection.dart';
import 'package:move_app/features/details/presentation/logic/movie_details_cubit.dart';
import 'package:move_app/features/details/presentation/screens/movie_details_screen.dart';
import 'package:move_app/features/home/presentation/logic/all_movies_cubit.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Home Screen
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AllMoviesCubit>()..emitGetAllMovies(),
            child: const HomeScreen(),
          ),
        );

      // Movie Details Screen
      case Routes.movieDetailsScreen:
        final movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<MovieDetailsCubit>()..emitGetMovieDetails(movieId),
            child: MovieDetailsScreen(movieId: movieId),
          ),
        );

      default:
        return null;
    }
  }
}
