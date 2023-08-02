import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  AppPreferences _appPreferences;
  DioFactory(this._appPreferences);
  Future<Dio> getDio() async{

    Dio dio = Dio();
    Duration _timeOut = const Duration(minutes: 1);
    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE:APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: language // todo get lan grom app prefs
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      headers: headers
    );

    if(kReleaseMode) {
      print("Release Mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true
      ));
    }
    return dio;
  }
}