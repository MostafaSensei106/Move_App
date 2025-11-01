import 'package:move_app/features/details/data/models/movie_details_model.dart';

import '../../../../core/networking/api_network_exceptions.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_services.dart';

/// A repository responsible for fetching movie details from the API.
class MovieDetailsRepo {
  /// The API service used to make network requests.
  final ApiServices apiServices;

  /// Creates a [MovieDetailsRepo] with the given [ApiServices].
  MovieDetailsRepo(this.apiServices);

  /// Fetches the details for a movie with the specified [id].
  ///
  /// Returns an [ApiResult] containing either the [MovieDetailsModel] on success
  /// or an [ApiErrorModel] on failure.
  Future<ApiResult<MovieDetailsModel>> getMovieDetails(int id) async {
    try {
      // Make the API call to get movie details.
      var response = await apiServices.movieDetails(id);
      // Wrap the successful response in an ApiResult.
      return ApiResult.success(response);
    } catch (error) {
      // Wrap the error in an ApiResult.
      return ApiResult.failure(ApiNetworkExceptions.getDioException(error));
    }
  }
}
