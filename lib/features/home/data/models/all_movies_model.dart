import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_movies_model.g.dart';

/// A data model representing a paginated list of movies.
///
/// This model is used for API responses that return a list of movies with pagination details.
@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class AllMoviesModel extends HiveObject {
  /// The current page number.
  @HiveField(0)
  final int? page;

  /// The list of movies on the current page.
  @HiveField(1)
  final List<MovieModel>? results;

  /// The total number of pages available.
  @HiveField(2)
  @JsonKey(name: 'total_pages')
  final int? totalPages;

  /// The total number of movie results available.
  @HiveField(3)
  @JsonKey(name: 'total_results')
  final int? totalResults;

  /// Creates an [AllMoviesModel] instance.
  AllMoviesModel({this.page, this.results, this.totalPages, this.totalResults});

  /// Creates an [AllMoviesModel] from a JSON map.
  factory AllMoviesModel.fromJson(Map<String, dynamic> json) =>
      _$AllMoviesModelFromJson(json);

  /// Converts this [AllMoviesModel] to a JSON map.
  Map<String, dynamic> toJson() => _$AllMoviesModelToJson(this);

  /// Creates a copy of this model with optional new values.
  AllMoviesModel copyWith({
    int? page,
    List<MovieModel>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return AllMoviesModel(
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}

/// A data model representing a single movie in a list.
///
/// This is a more compact model used for movie listings.
@HiveType(typeId: 1)
@JsonSerializable()
class MovieModel extends HiveObject {
  /// Indicates if the movie is intended for an adult audience.
  @HiveField(0)
  final bool? adult;

  /// The path to the movie's backdrop image.
  @HiveField(1)
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  /// A list of genre IDs associated with the movie.
  @HiveField(2)
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  /// The unique identifier for the movie.
  @HiveField(3)
  final int? id;

  /// The original language of the movie.
  @HiveField(4)
  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  /// The original title of the movie.
  @HiveField(5)
  @JsonKey(name: 'original_title')
  final String? originalTitle;

  /// A brief overview or synopsis of the movie.
  @HiveField(6)
  final String? overview;

  /// The popularity score of the movie.
  @HiveField(7)
  final double? popularity;

  /// The path to the movie's poster image.
  @HiveField(8)
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  /// The release date of the movie.
  @HiveField(9)
  @JsonKey(name: 'release_date')
  final String? releaseDate;

  /// The title of the movie.
  @HiveField(10)
  final String? title;

  /// Indicates if the movie has a video (e.g., a trailer).
  @HiveField(11)
  final bool? video;

  /// The average vote score.
  @HiveField(12)
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  /// The total number of votes received.
  @HiveField(13)
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  /// Creates a [MovieModel] instance.
  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  /// Creates a [MovieModel] from a JSON map.
  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  /// Converts this [MovieModel] to a JSON map.
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  @override
  String toString() =>
      'MovieModel(id: $id, title: $title, releaseDate: $releaseDate)';
}
