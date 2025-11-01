import 'package:dio/dio.dart';
import 'package:move_app/features/details/data/models/movie_details_model.dart';
import 'package:move_app/features/home/data/models/all_movies_model.dart';
import 'package:retrofit/retrofit.dart';

import 'api_constants.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  // All Movies API
  @GET(ApiConstants.apiAllMovies)
  Future<AllMoviesModel> allMovies(@Query('page') String page);

  // Movie Details API
  @GET(ApiConstants.apiMovieDetails)
  Future<MovieDetailsModel> movieDetails(@Path('movie_id') int id);
}
