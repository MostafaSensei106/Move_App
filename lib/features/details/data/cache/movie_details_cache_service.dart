import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/cache/hive_cache_service.dart';
import '../models/movie_details_model.dart';

class MovieDetailsCacheService implements HiveCacheService<MovieDetailsModel> {
  static const String movieDetailsBoxName = 'movieDetailsBox';

  static Future<void> init() async {
    if (!Hive.isBoxOpen(movieDetailsBoxName)) {
      await Hive.openBox<MovieDetailsModel>(movieDetailsBoxName);
    }
  }

  @override
  Future<void> cacheItem(String key, MovieDetailsModel item) async {
    final box = Hive.box<MovieDetailsModel>(movieDetailsBoxName);
    await box.put(key, item);
  }

  @override
  MovieDetailsModel? getCachedItem(String key) {
    final box = Hive.box<MovieDetailsModel>(movieDetailsBoxName);
    return box.get(key);
  }

  @override
  Future<void> clearCachedItem(String key) async {
    final box = Hive.box<MovieDetailsModel>(movieDetailsBoxName);
    await box.delete(key);
  }

  @override
  Future<void> clearAll() async {
    final box = Hive.box<MovieDetailsModel>(movieDetailsBoxName);
    await box.clear();
  }

  @override
  bool hasItem(String key) {
    final box = Hive.box<MovieDetailsModel>(movieDetailsBoxName);
    return box.containsKey(key);
  }

  Future<void> cacheMovieDetails(
    int movieId,
    MovieDetailsModel movieDetails,
  ) async {
    await cacheItem('movie_details_$movieId', movieDetails);
  }

  MovieDetailsModel? getCachedMovieDetails(int movieId) {
    return getCachedItem('movie_details_$movieId');
  }

  Future<void> clearCachedMovieDetails(int movieId) async {
    await clearCachedItem('movie_details_$movieId');
  }
}
