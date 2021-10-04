import 'dart:async';
import 'dart:convert';
import 'dart:io' as IO;

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_retry/dio_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpClient {
  static Future<BaseOptions> _options() async {
    return BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
  }

  static Future<Dio> _dioClient() async {

    Dio dio = Dio(await _options());
    dio.interceptors.add(
      RetryInterceptor(
          options: RetryOptions(
            retries: 1,
            retryInterval: Duration(seconds: 3),
            retryEvaluator: (error) =>
            error.type != DioErrorType.CANCEL &&
                error.type != DioErrorType.RESPONSE,
          ),
          dio: dio),
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));


    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (IO.HttpClient client) {
      client.badCertificateCallback =
          (IO.X509Certificate cert, String host, int port) => true;
    };
    return dio;
  }

  static Future<dynamic> get(String url) async {
    try {
      Dio dio = await _dioClient();
      Response response = await dio.get(url);
      return response.data;
    } catch (e) {
      throw e;
    }
  }

}
