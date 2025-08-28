import 'dart:io';

import 'package:battery/common/services/user.dart';
import 'package:battery/common/values/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "en";
const int CONNECT_TIMEOUT = 5; // 20秒
const int RECEIVE_TIMEOUT = 5; // 20秒

class BatteryHttpService extends GetxService {
  static BatteryHttpService get to => Get.find();

  late final Dio _dio;
  final CancelToken _cancelToken = CancelToken();

  @override
  void onInit() {
    super.onInit();

    var options = BaseOptions(
      baseUrl: Constants.apiUrl,
      connectTimeout: const Duration(seconds: CONNECT_TIMEOUT),
      receiveTimeout: const Duration(seconds: RECEIVE_TIMEOUT),
      headers: {},
      responseType: ResponseType.json,
      contentType: 'application/json',
    );

    _dio = Dio(options);

    _dio.interceptors.add(RequestInterceptors());

    // 拦截器 - 日志打印
    if (!kReleaseMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
    }
  }

  Future<Response<T>> _request<T>(
    Future<Response<T>> Function() requestFunction,
  ) async {
    try {
      final response = await requestFunction();
      return response;
    } on DioException catch (e) {
      // 捕获并处理 Dio 异常
      return _handleDioError(e);
    }
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _request(() => _dio.get(
          url,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _request(() => _dio.post(
          url,
          data: data,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  Future<Response> put(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _request(() => _dio.put(
          url,
          data: data,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  Future<Response> delete(
    String url, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _request(() => _dio.delete(
          url,
          data: data,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  Response<T> _handleDioError<T>(DioException e) {
    final exception = HttpException(e.message ?? "错误");
    if (e.type == DioExceptionType.connectionTimeout) {
      // NotificationService.showToast('请求超时，请稍后重试');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      // NotificationService.showToast('接收超时，请检查您的网络连接');
    } else if (e.type == DioExceptionType.badResponse) {
      final response = e.response;
      // final errorMessage = ErrorMessageModel.fromJson(response?.data);
      // if (errorMessage.message != null) {
      // NotificationService.showToast(errorMessage.message!);
      // }
    } else {
      // NotificationService.showToast('网络错误');
    }
    throw exception;
  }
}

class RequestInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 可以添加公共参数或对请求参数进行加密
    if (Get.isRegistered<UserService>() &&
        UserService.to.user.value.token.isNotEmpty) {
      options.headers['token'] = UserService.to.user.value.token;
    }
    if (Constants.languageLocale != null) {
      if (Constants.languageLocale?.languageCode == 'zh') {
        options.headers['lang'] = 'zh-cn';
      } else {
        options.headers['lang'] = Constants.languageLocale?.languageCode;
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
        true,
      );
    } else {
      handler.next(response);
    }
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final exception = HttpException(err.message ?? "错误");
    if (err.type == DioExceptionType.badResponse) {
      final response = err.response;
      // 假设服务器返回401表示token过期
      if (response?.statusCode == 401) {
        // 处理token过期逻辑
        _handleTokenExpired();
      }

      // final errorMessage = ErrorMessageModel.fromJson(response?.data);
      // if (errorMessage.message != null) {
      // NotificationService.showToast(errorMessage.message!);
      // }
    } else if (err.type == DioExceptionType.connectionTimeout) {
      // NotificationService.showToast('请求超时，请稍后重试');
    } else if (err.type == DioExceptionType.receiveTimeout) {
      // NotificationService.showToast('接收超时，请检查您的网络连接');
    } else {
      // NotificationService.showToast('网络错误');
    }
    handler.next(err.copyWith(error: exception));
  }

  void _handleTokenExpired() {
    // 提示用户重新登录
    // NotificationService.showToast("登录已过期，请重新登录");

    // // 清除用户信息并跳转到登录页面
    // UserService.to.logout();
    // Get.toNamed(RouteNames.installLogin); // 跳转到登录页面
  }
}
