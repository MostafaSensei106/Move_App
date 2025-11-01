import 'api_error_handler.dart';
import 'api_error_model.dart';

class ApiNetworkExceptions {
  final ApiErrorModel? errorModel;
  final String? message;

  ApiNetworkExceptions({this.errorModel, this.message});

  factory ApiNetworkExceptions.fromApiErrorModel(ApiErrorModel errorModel) {
    return ApiNetworkExceptions(
      errorModel: errorModel,
      message: getErrorMessage(errorModel),
    );
  }

  static ApiErrorModel getDioException(dynamic error) {
    if (error is ApiErrorModel) {
      return error;
    }
    return ErrorHandler.handle(error).apiErrorModel;
  }

  static String getErrorMessage(ApiErrorModel error) {
    if (error.statusMessage != null && error.statusMessage!.isNotEmpty) {
      return error.statusMessage!;
    }
    return error.statusMessage ??
        "An unexpected error occurred. Please try again.";
  }

  static String getErrorFromException(dynamic exception) {
    if (exception is String) return exception;
    if (exception is ApiErrorModel) return getErrorMessage(exception);
    return getErrorMessage(getDioException(exception));
  }

  String getDisplayMessage() {
    return message ?? "An unexpected error occurred. Please try again.";
  }

  @override
  String toString() {
    return getDisplayMessage();
  }
}
