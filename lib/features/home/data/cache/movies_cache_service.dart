import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/cache/hive_cache_service.dart';
import '../models/all_movies_model.dart';

/// A caching service for movie lists, implementing [HiveCacheService].
///
/// This class manages the storage and retrieval of [AllMoviesModel] objects
/// in a dedicated Hive box.
class MoviesCacheService implements HiveCacheService<AllMoviesModel> {
  /// The name of the Hive box used for storing movie lists.
  static const String moviesBoxName = 'moviesBox';

  /// Initializes the movies cache.
  ///
  /// This method opens the Hive box if it's not already open.
  static Future<void> init() async {
    if (!Hive.isBoxOpen(moviesBoxName)) {
      await Hive.openBox<AllMoviesModel>(moviesBoxName);
    }
  }

  @override
  Future<void> cacheItem(String key, AllMoviesModel item) async {
    final box = Hive.box<AllMoviesModel>(moviesBoxName);
    await box.put(key, item);
  }

  @override
  AllMoviesModel? getCachedItem(String key) {
    final box = Hive.box<AllMoviesModel>(moviesBoxName);
    return box.get(key);
  }

  @override
  Future<void> clearCachedItem(String key) async {
    final box = Hive.box<AllMoviesModel>(moviesBoxName);
    await box.delete(key);
  }

  @override
  Future<void> clearAll() async {
    final box = Hive.box<AllMoviesModel>(moviesBoxName);
    await box.clear();
  }

  @override
  bool hasItem(String key) {
    final box = Hive.box<AllMoviesModel>(moviesBoxName);
    return box.containsKey(key);
  }

  /// Caches a list of movies under a general key.
  Future<void> cacheMovies(AllMoviesModel movies) async {
    await cacheItem('cachedMovies', movies);
  }

  /// Retrieves the general cached list of movies.
  AllMoviesModel? getCachedMovies() {
    return getCachedItem('cachedMovies');
  }

  /// Clears the general cached list of movies.
  Future<void> clearCachedMovies() async {
    await clearCachedItem('cachedMovies');
  }

  /// Caches a specific page of movies.
  Future<void> cacheMoviesByPage(int page, AllMoviesModel movies) async {
    await cacheItem('movies_page_$page', movies);
  }

  /// Retrieves a cached page of movies.
  AllMoviesModel? getCachedMoviesByPage(int page) {
    return getCachedItem('movies_page_$page');
  }
}
