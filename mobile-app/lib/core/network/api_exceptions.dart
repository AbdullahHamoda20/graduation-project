import 'package:dio/dio.dart';
import 'api_error.dart';

class ApiExpectations {
  static ApiError handleError(DioException error) {
    String message = "Unexpected error";

    switch (error.type) {

      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'No Internet Connection');

      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'Server is not responding');

      case DioExceptionType.badResponse:
        final data = error.response?.data;

        if (data is Map<String, dynamic>) {
          message = data["message"] ?? "Server error";
        } else if (data is String) {
          message = data;
        }

        return ApiError(
          message: message,
          statusCode: error.response?.statusCode,
        );

      case DioExceptionType.unknown:
        return ApiError(message: "No Internet or Unknown error");

      default:
        return ApiError(message: "Unexpected error");
    }
  }
}