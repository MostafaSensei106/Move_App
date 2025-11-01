import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_details_state.freezed.dart';

/// A sealed class representing the different states of the movie details screen.
@freezed
class MovieDetailsState<T> with _$MovieDetailsState<T> {
  /// The initial state before any action has been taken.
  const factory MovieDetailsState.idle() = Idle<T>;

  /// The state when movie details are being loaded.
  const factory MovieDetailsState.loading() = Loading<T>;

  /// The state when movie details have been successfully loaded.
  ///
  /// - [movieDetails]: The loaded movie data.
  /// - [isFromCache]: A flag indicating if the data was loaded from the cache.
  const factory MovieDetailsState.success({
    required T movieDetails,
    required bool isFromCache,
  }) = Success<T>;

  /// The state when an error has occurred.
  ///
  /// - [error]: A string describing the error.
  const factory MovieDetailsState.error({required String error}) = Error;
}
