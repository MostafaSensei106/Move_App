import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/features/details/data/cache/movie_details_cache_service.dart';
import 'package:move_app/features/details/data/models/movie_details_model.dart';
import 'package:move_app/features/details/data/repos/movie_details_repo.dart';
import 'package:move_app/features/details/presentation/logic/movie_details_state.dart';

/// A [Cubit] that manages the state for the movie details screen.
///
/// It fetches movie details from the repository and manages loading, success,
/// and error states.
class MovieDetailsCubit extends Cubit<MovieDetailsState<MovieDetailsModel>> {
  /// The repository for fetching movie details.
  final MovieDetailsRepo movieDetailsRepo;

  /// The service for caching movie details.
  final MovieDetailsCacheService movieDetailsCacheService;

  /// Creates a [MovieDetailsCubit] instance.
  MovieDetailsCubit(this.movieDetailsRepo, this.movieDetailsCacheService)
      : super(const Idle());

  /// Fetches and emits the state for movie details.
  ///
  /// It first attempts to load data from the cache. If available, it emits a
  /// success state immediately. It then proceeds to fetch fresh data from the
  /// network, updating the state accordingly.
  void emitGetMovieDetails(int id) async {
    // Emit loading state.
    emit(const MovieDetailsState.loading());

    try {
      // Try to get the movie details from the cache first.
      final cachedMovieDetails = movieDetailsCacheService.getCachedMovieDetails(
        id,
      );

      // If cached data exists, emit a success state with the cached data.
      if (cachedMovieDetails != null) {
        emit(
          MovieDetailsState.success(
            movieDetails: cachedMovieDetails,
            isFromCache: true,
          ),
        );
      }

      // Fetch fresh data from the repository.
      final result = await movieDetailsRepo.getMovieDetails(id);

      result.when(
        success: (MovieDetailsModel movieDetails) {
          // On success, cache the newly fetched data.
          movieDetailsCacheService.cacheMovieDetails(id, movieDetails);

          // Emit a success state with the fresh data.
          emit(
            MovieDetailsState.success(
              movieDetails: movieDetails,
              isFromCache: false,
            ),
          );
        },
        failure: (error) {
          // If the network call fails and there's no cached data, emit an error state.
          if (cachedMovieDetails == null) {
            final errorMessage =
                error.statusMessage ?? 'Failed to load movie details';
            emit(MovieDetailsState.error(error: errorMessage));
          }
          // If cached data is already shown, we can choose to silently fail.
        },
      );
    } catch (e) {
      // Handle any other exceptions.
      final cachedMovieDetails = movieDetailsCacheService.getCachedMovieDetails(
        id,
      );
      if (cachedMovieDetails != null) {
        // If there's cached data, show it instead of a generic error.
        emit(
          MovieDetailsState.success(
            movieDetails: cachedMovieDetails,
            isFromCache: true,
          ),
        );
      } else {
        // Otherwise, emit a generic error state.
        emit(MovieDetailsState.error(error: e.toString()));
      }
    }
  }
}
