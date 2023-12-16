import 'package:dio/src/dio_exception.dart';

import '../app_strings.dart';

String getDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      return AppStrings.noInternetError;
    case DioExceptionType.connectionTimeout:
      return AppStrings.noInternetError;
    case DioExceptionType.receiveTimeout:
      return AppStrings.noInternetError;
    case DioExceptionType.sendTimeout:
      return AppStrings.noInternetError;
    default:
      return AppStrings.unknownError;
  }
}
