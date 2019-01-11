import 'package:dio/dio.dart';

class HttpException implements Exception{
  Response response;

  HttpException(this.response);
}