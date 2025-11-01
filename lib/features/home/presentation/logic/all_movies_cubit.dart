import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app/features/home/data/cache/movies_cache_service.dart';
import 'package:move_app/features/home/data/models/all_movies_model.dart';
import 'package:move_app/features/home/data/repos/all_movies_repo.dart';
import 'package:move_app/features/home/presentation/logic/all_movies_state.dart';

/// A [Cubit] that manages the state for the home screen, including fetching
/// and paginating the list of all movies.
class AllMoviesCubit extends Cubit<AllMoviesState<AllMoviesModel>> {
  /// The repository for fetching movie data.
  final AllMoviesRepo allMoviesRepo;

  /// The service for caching movie data.
  final MoviesCacheService moviesCacheService;

  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMorePages = true;
  List<MovieModel> _allMovies = [];

  /// Creates an [AllMoviesCubit] instance.
  AllMoviesCubit(this.allMoviesRepo, this.moviesCacheService)
      : super(const Idle());

  /// Indicates if more movies are currently being loaded.
  bool get isLoadingMore => _isLoadingMore;

  /// Indicates if there are more pages of movies to load.
  bool get hasMorePages => _hasMorePages;

  /// The current page number of the movie list.
  int get currentPage => _currentPage;

  /// Fetches the initial list of movies.
  ///
  /// It first tries to load from the cache. If successful, it displays the cached
  /// data and then fetches fresh data from the network in the background.
  void emitGetAllMovies() async {
    emit(const AllMoviesState.loading());

    try {
      // Attempt to load the full movie list from the cache.
      final cachedAllMovies = moviesCacheService.getCachedMovies();

      if (cachedAllMovies != null && cachedAllMovies.results != null) {
        _allMovies = List.from(cachedAllMovies.results!);
        _currentPage = cachedAllMovies.page ?? 1;
        _hasMorePages = (_currentPage < (cachedAllMovies.totalPages ?? 1));

        // Emit cached data immediately.
        emit(
          AllMoviesState.success(allMovies: cachedAllMovies, isFromCache: true),
        );
      }

      // Fetch the first page from the network.
      final result = await allMoviesRepo.getAllMovies('1');

      result.when(
        success: (AllMoviesModel allMovies) async {
          // Cache the fresh data.
          await moviesCacheService.cacheMovies(allMovies.copyWith());
          await moviesCacheService.cacheMoviesByPage(1, allMovies.copyWith());

          _allMovies = List.from(allMovies.results ?? []);
          _currentPage = allMovies.page ?? 1;
          _hasMorePages = (_currentPage < (allMovies.totalPages ?? 1));

          // Emit success state with fresh data.
          emit(
            AllMoviesState.success(allMovies: allMovies, isFromCache: false),
          );
        },
        failure: (error) {
          // If the network fails but we have cached data, do nothing.
          if (cachedAllMovies != null) {
            return;
          }

          // Otherwise, emit an error state.
          final errorMessage =
              error.statusMessage ?? 'Failed to load movies. Please try again.';
          emit(AllMoviesState.error(error: errorMessage));
        },
      );
    } catch (e) {
      // Handle other exceptions.
      final cachedAllMovies = moviesCacheService.getCachedMovies();
      if (cachedAllMovies != null && cachedAllMovies.results != null) {
        // If there's an error but we have cache, show the cache.
        _allMovies = List.from(cachedAllMovies.results!);
        _currentPage = cachedAllMovies.page ?? 1;
        _hasMorePages = (_currentPage < (cachedAllMovies.totalPages ?? 1));

        emit(
          AllMoviesState.success(allMovies: cachedAllMovies, isFromCache: true),
        );
      } else {
        // If no cache is available, show the error.
        emit(AllMoviesState.error(error: e.toString()));
      }
    }
  }

  /// Loads the next page of movies for infinite scrolling.
  Future<void> loadMoreMovies() async {
    if (_isLoadingMore || !_hasMorePages) return;

    _isLoadingMore = true;
    final nextPage = _currentPage + 1;

    // Emit a loadingMore state to show a loading indicator at the bottom of the list.
    final currentMovies = AllMoviesModel(
      page: _currentPage,
      results: _allMovies,
      totalPages: null, // Total pages might change, so we nullify it here.
      totalResults: null,
    );
    emit(AllMoviesState.loadingMore(allMovies: currentMovies));

    try {
      // Try to load the next page from the cache.
      final cachedPageMovies = moviesCacheService.getCachedMoviesByPage(
        nextPage,
      );

      if (cachedPageMovies != null && cachedPageMovies.results != null) {
        _allMovies.addAll(cachedPageMovies.results!);
        _currentPage = nextPage;
        _hasMorePages =
            (_currentPage < (cachedPageMovies.totalPages ?? _currentPage));

        final combinedMovies = AllMoviesModel(
          page: _currentPage,
          results: _allMovies,
          totalPages: cachedPageMovies.totalPages,
          totalResults: cachedPageMovies.totalResults,
        );

        emit(
          AllMoviesState.success(allMovies: combinedMovies, isFromCache: true),
        );
      }

      // Fetch the next page from the network.
      final result = await allMoviesRepo.getAllMovies(nextPage.toString());

      result.when(
        success: (AllMoviesModel newMovies) async {
          if (newMovies.results != null) {
            // Cache the new page.
            await moviesCacheService.cacheMoviesByPage(nextPage, newMovies);

            // Ensure no duplicate movies are added.
            final newMovieIds = _allMovies.map((m) => m.id).toSet();
            final uniqueNewMovies = newMovies.results!
                .where((movie) => !newMovieIds.contains(movie.id))
                .toList();

            _allMovies.addAll(uniqueNewMovies);
            _currentPage = nextPage;
            _hasMorePages =
                (_currentPage < (newMovies.totalPages ?? _currentPage));

            final combinedMovies = AllMoviesModel(
              page: _currentPage,
              results: _allMovies,
              totalPages: newMovies.totalPages,
              totalResults: newMovies.totalResults,
            );

            // Update the main cache with the combined list.
            await moviesCacheService.cacheMovies(combinedMovies.copyWith());

            emit(
              AllMoviesState.success(
                allMovies: combinedMovies,
                isFromCache: false,
              ),
            );
          }
        },
        failure: (error) {
          // If fetching more fails, we just stop showing the loading indicator.
          // The user can try again by scrolling.
          if (cachedPageMovies == null) {}
        },
      );
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Refreshes the movie list, clearing existing data and fetching page 1.
  Future<void> refreshMovies() async {
    _currentPage = 1;
    _allMovies.clear();
    _hasMorePages = true;
    emitGetAllMovies();
  }

  /// Resets the pagination state.
  void resetPagination() {
    _currentPage = 1;
    _allMovies.clear();
    _hasMorePages = true;
    _isLoadingMore = false;
  }
}
