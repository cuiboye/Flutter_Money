import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'dart:convert';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(String? reason, int? code);
typedef After = void Function();

class DioInstance {
  static Dio? _dio;
  static DioInstance https = DioInstance();

  static DioInstance getInstance() {
    return https;
  }

  DioInstance() {
    _dio ??= createDio();
  }

  Dio createDio() {
    var dio = Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      sendTimeout: 30000,
      baseUrl: "http://192.168.0.101:8083",
      responseType: ResponseType.json,
    ));
    //添加拦截器，这里添加Dio的日志
    dio.interceptors.add(DioLogInterceptor());

    return dio;
  }

  Future<void> get(String uri, Map<String, dynamic> params, {Success? success, Fail? fail, After? after}) {
    _dio?.get(uri, queryParameters: params).then((response) {
      if (response.statusCode == 200) {
        if (success != null) {
          success(json.decode(response.data));
        }
      } else {
        if (fail != null) {
          fail(response.statusMessage, response.statusCode);
        }
      }

      if (after != null) {
        after();
      }
    });
    return Future.value();
  }

  Future<void> post(String uri, FormData formData, {Success? success, Fail? fail, After? after}) {
    _dio?.post(uri, data: formData,options: Options(contentType: "multipart/form-data")).then((response) {
      if (response.statusCode == 200) {
        if (success != null) {
          success(json.decode(response.data));
        }
      } else {
        if (fail != null) {
          fail(response.statusMessage, response.statusCode);
        }
      }

      if (after != null) {
        after();
      }
    });
    return Future.value();
  }
}
