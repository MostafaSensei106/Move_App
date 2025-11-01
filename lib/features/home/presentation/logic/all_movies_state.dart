import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_movies_state.freezed.dart';

/// A sealed class representing the different states for the All Movies screen.
@freezed
class AllMoviesState<T> with _$AllMoviesState<T> {
  /// The initial state before any data is loaded.
  const factory AllMoviesState.idle() = Idle<T>;

  /// The state when the initial list of movies is being loaded.
  const factory AllMoviesState.loading() = Loading<T>;

  /// The state when the list of movies has been successfully loaded.
  ///
  /// - [allMovies]: The loaded movie data.
  /// - [isFromCache]: A flag indicating if the data was from the cache.
  const factory AllMoviesState.success({
    required T allMovies,
    required bool isFromCache,
  }) = Success<T>;

  /// The state when more movies are being loaded for pagination.
  ///
  /// - [allMovies]: The current list of movies that is being added to.
  const factory AllMoviesState.loadingMore({required T allMovies}) =
      LoadingMore<T>;

  /// The state when an error has occurred.
  ///
  /// - [error]: A string describing the error.
  const factory AllMoviesState.error({required String error}) = Error;
}
