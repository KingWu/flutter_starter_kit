import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/app/model/pojo/response/LookupResponse.dart';
import 'package:flutter_starter_kit/app/model/pojo/response/TopAppResponse.dart';
import 'package:flutter_starter_kit/utility/http/HttpException.dart';
import 'package:flutter_starter_kit/utility/log/Log.dart';
import 'package:sprintf/sprintf.dart';

class APIProvider{

  static const String _baseUrl = 'https://itunes.apple.com/hk';
  static const String _TOP_FREE_APP_API = '/rss/topfreeapplications/limit=%d/json';
  static const String _TOP_FEATURE_APP_API = '/rss/topgrossingapplications/limit=%d/json';
  static const String _APP_DETAIL_API = '/lookup/json';

  Dio _dio;

  APIProvider(){
    Options dioOptions = Options()
      ..baseUrl = APIProvider._baseUrl;

    _dio = Dio(dioOptions);
  }

  Future<TopAppResponse> getTopFreeApp(int limit) async{
    Response response = await _dio.get(sprintf(APIProvider._TOP_FREE_APP_API, [limit]));
    throwIfNoSuccess(response);
    return TopAppResponse.fromJson(jsonDecode(response.data));
  }

  Future<TopAppResponse> getTopFeatureApp(int limit) async{
    Response response = await _dio.get(sprintf(APIProvider._TOP_FEATURE_APP_API, [limit]));
    throwIfNoSuccess(response);
    return TopAppResponse.fromJson(jsonDecode(response.data));
  }

  Future<LookupResponse> getAppDetail(String id) async{
    Response response = await _dio.get(APIProvider._APP_DETAIL_API, data:{'id':id});
    throwIfNoSuccess(response);
    return LookupResponse.fromJson(jsonDecode(response.data));
  }

  void throwIfNoSuccess(Response response) {
    if(response.statusCode < 200 || response.statusCode > 299) {
      throw new HttpException(response);
    }
  }

}