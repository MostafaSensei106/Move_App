import 'package:move_app/features/home/data/models/all_movies_model.dart';

import '../../../../core/networking/api_network_exceptions.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_services.dart';

/// A repository for fetching a list of all movies from the API.
class AllMoviesRepo {
  /// The API service used to make network requests.
  final ApiServices apiServices;

  /// Creates an [AllMoviesRepo] with the given [ApiServices].
  AllMoviesRepo(this.apiServices);

  /// Fetches a paginated list of all movies.
  ///
  /// The [page] parameter specifies which page of results to retrieve.
  /// Returns an [ApiResult] containing either an [AllMoviesModel] on success
  /// or an [ApiErrorModel] on failure.
  Future<ApiResult<AllMoviesModel>> getAllMovies(String page) async {
    try {
      // Make the API call to get the list of movies.
      var response = await apiServices.allMovies(page);
      // Wrap the successful response in an ApiResult.
      return ApiResult.success(response);
    } catch (error) {
      // Wrap any errors in an ApiResult.
      return ApiResult.failure(ApiNetworkExceptions.getDioException(error));
    }
  }
}
