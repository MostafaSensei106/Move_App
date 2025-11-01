import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:move_app/features/details/data/cache/movie_details_cache_service.dart';
import 'package:move_app/features/details/data/repos/movie_details_repo.dart';
import 'package:move_app/features/details/presentation/logic/movie_details_cubit.dart';
import 'package:move_app/features/home/data/cache/movies_cache_service.dart';
import 'package:move_app/features/home/data/repos/all_movies_repo.dart';
import 'package:move_app/features/home/presentation/logic/all_movies_cubit.dart';

import '../networking/api_services.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(dio));

  // All Movies
  getIt.registerLazySingleton<MoviesCacheService>(() => MoviesCacheService());
  getIt.registerLazySingleton<AllMoviesRepo>(() => AllMoviesRepo(getIt()));
  getIt.registerFactory<AllMoviesCubit>(() => AllMoviesCubit(getIt(), getIt()));

  // Movie Details
  getIt.registerLazySingleton<MovieDetailsCacheService>(
    () => MovieDetailsCacheService(),
  );
  getIt.registerLazySingleton<MovieDetailsRepo>(
    () => MovieDetailsRepo(getIt()),
  );
  getIt.registerFactory<MovieDetailsCubit>(
    () => MovieDetailsCubit(getIt(), getIt()),
  );
}
