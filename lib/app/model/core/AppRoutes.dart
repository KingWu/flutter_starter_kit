import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/ui/page/AppDetailPage.dart';
import 'package:flutter_starter_kit/app/ui/page/HomePage.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return HomePage();
    });

var appDetailRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String appId = params['appId']?.first;
      String heroTag = params['heroTag']?.first;
      String title = params['title']?.first;
      String url = params['url']?.first;
      String titleTag = params['titleTag']?.first;


      return new AppDetailPage(appId: num.parse(appId), heroTag:heroTag,title: title, url: url, titleTag: titleTag);
    });

class AppRoutes {

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print('ROUTE WAS NOT FOUND !!!');
        });
    router.define(HomePage.PATH, handler: rootHandler);
    router.define(AppDetailPage.PATH, handler: appDetailRouteHandler);
  }
}