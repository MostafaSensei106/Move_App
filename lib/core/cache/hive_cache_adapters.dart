import 'package:hive_flutter/hive_flutter.dart';
import 'package:move_app/features/details/data/models/movie_details_model.dart';
import 'package:move_app/features/home/data/models/all_movies_model.dart';

class HiveCacheAdapters {
  static void registerAdapters() {
    // Register all Hive type adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AllMoviesModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MovieModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(MovieDetailsModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(GenreAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(ProductionCompanyAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(ProductionCountryAdapter());
    }
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(SpokenLanguageAdapter());
    }
  }

  /// Initialize Hive with Flutter
  static Future<void> init() async {
    await Hive.initFlutter();
    registerAdapters();
  }
}
