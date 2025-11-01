class ApiConstants {
  // API Key
  static const String apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMjlkN2ExNzk4OWExNDU0MjJiNmIwMjMwYzBhNDdiZCIsIm5iZiI6MTc2MTgyMDQ2My40NzIsInN1YiI6IjY5MDMzZjJmMjFjYjMxMGQzODlhN2I4MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8R-x3Lbh_uIoEKV-SmJdN17goI0hfY6wpNOjsUQKXmg";

  // Base URL for the API
  static const String apiBaseUrl = "https://api.themoviedb.org/3/";

  // All Movies
  static const String apiAllMovies = "movie/popular";
  static const String apiMovieDetails = "movie/{movie_id}";
}

class ApiErrors {
  static const String badRequestError =
      "Invalid request. Please check the entered data.";
  static const String noContent = "No content available.";
  static const String forbiddenError =
      "You do not have permission to access this resource.";
  static const String unauthorizedError = "You must log in to continue.";
  static const String notFoundError = "The requested resource was not found.";
  static const String conflictError = "A data conflict occurred.";
  static const String internalServerError =
      "A server error occurred. Please try again later.";
  static const String unknownError =
      "An unknown error occurred. Please try again.";
  static const String timeoutError =
      "Connection timeout. Please check your internet connection and try again.";
  static const String defaultError =
      "An unexpected error occurred. Please try again.";
  static const String cacheError = "A cache error occurred.";
  static const String noInternetError =
      "No internet connection. Please check your connection and try again.";
  static const String loadingMessage = "Loading...";
  static const String retryAgainMessage = "Please try again.";
  static const String ok = "OK";
}
