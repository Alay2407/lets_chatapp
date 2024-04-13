import 'package:dio/dio.dart';
import '../../constants/strings.dart';
import 'failure.dart';
import 'package:dio/io.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      print('Inside if state');
      failure = _handleError(error);
    } else {
      print('Inside else state');
      failure = DataSource.DEFAULT.getFailure(error);
    }
  }

  Failure _handleError(DioException error) {
    if (error.type case DioExceptionType.connectionTimeout) {
      return DataSource.CONNECT_TIMEOUT.getFailure(error);
    } else if (error.type case DioExceptionType.sendTimeout) {
      return DataSource.SEND_TIMEOUT.getFailure(error);
    } else if (error.type case DioExceptionType.receiveTimeout) {
      return DataSource.RECEIVE_TIMEOUT.getFailure(error);
    } else if (error.type case DioExceptionType.badResponse) {
      switch (error.response?.statusCode) {
        case ResponseCode.BAD_REQUEST:
          List<dynamic> messages = error.response!.data['message'];
          print('Error msg is ===> ${messages.first['msg']}');
          return DataSource.BAD_REQUEST.getFailure(messages.first['msg']);
        case ResponseCode.FORBIDDEN:
          return DataSource.FORBIDDEN.getFailure(error.response!.data['message']);
        case ResponseCode.UNAUTHORISED:
          return DataSource.UNAUTHORISED.getFailure(error.response!.data['message']);
        case ResponseCode.NOT_FOUND:
          return DataSource.NOT_FOUND.getFailure(error.response!.data['message']);
        case ResponseCode.INTERNAL_SERVER_ERROR:
          return DataSource.INTERNAL_SERVER_ERROR.getFailure(error.response!.data['message']);
        default:
          return DataSource.DEFAULT.getFailure(error.response!.statusCode);
      }
    } else if (error.type case DioExceptionType.cancel) {
      return DataSource.CANCEL.getFailure(error.response!.data['message']);
    } else if (error.type case DioExceptionType.unknown) {
      return DataSource.DEFAULT.getFailure(error);
    } else {
      return DataSource.DEFAULT.getFailure(error);
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure(error) {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return ServerFailure(error.toString());
      case DataSource.FORBIDDEN:
        return ServerFailure(error.toString());
      case DataSource.UNAUTHORISED:
        return ServerFailure(error.toString());
      case DataSource.NOT_FOUND:
        return ServerFailure(error.toString());
      case DataSource.INTERNAL_SERVER_ERROR:
        return ServerFailure(error.toString());
      case DataSource.CONNECT_TIMEOUT:
        return const ServerFailure(ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return ServerFailure(ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return const ServerFailure(ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return const ServerFailure(ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return const ServerFailure(ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return const ServerFailure(ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return ServerFailure(error.toString());
      default:
        return ServerFailure(error.toString());
    }
  }
}

class ResponseCode {
  // API status codes
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no content
  static const int BAD_REQUEST = 400; // failure, api rejected the request
  static const int FORBIDDEN = 403; // failure, api rejected the request
  static const int UNAUTHORISED = 401; // failure user is not authorised
  static const int NOT_FOUND = 404; // failure, api url is not correct and not found
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash happened in server side

  // local status code
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  // API status codes
  // API response codes
  static const String SUCCESS = AppStrings.success; // success with data
  static const String NO_CONTENT = AppStrings.noContent; // success with no content
  static const String BAD_REQUEST = AppStrings.badRequestError; // failure, api rejected our request
  static const String FORBIDDEN = AppStrings.forbiddenError; // failure,  api rejected our request
  static const String UNAUTHORISED = AppStrings.unauthorizedError; // failure, user is not authorised
  static const String NOT_FOUND = AppStrings.notFoundError; // failure, API url is not correct and not found in api side.
  static const String INTERNAL_SERVER_ERROR = AppStrings.internalServerError; // failure, a crash happened in API side.

  // local responses codes
  static const String DEFAULT = AppStrings.defaultError; // unknown error happened
  static const String CONNECT_TIMEOUT = AppStrings.timeoutError; // issue in connectivity
  static const String CANCEL = AppStrings.defaultError; // API request was cancelled
  static const String RECEIVE_TIMEOUT = AppStrings.timeoutError; //  issue in connectivity
  static const String SEND_TIMEOUT = AppStrings.timeoutError; //  issue in connectivity
  static const String CACHE_ERROR = AppStrings.defaultError; //  issue in getting data from local data source (cache)
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetError; // issue in connectivity
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
