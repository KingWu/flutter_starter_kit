import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/model/core/AppComponent.dart';
import 'package:flutter_starter_kit/app/model/core/AppStoreApplication.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

enum EnvType {
  DEVELOPMENT,
  STAGING,
  PRODUCTION,
  TESTING
}

class Env {

  static Env value;

  String appName;
  String baseUrl;
  Color primarySwatch;
  EnvType environmentType = EnvType.DEVELOPMENT;

  // Database Config
  int dbVersion = 1;
  String dbName;


  Env() {
    value = this;
    _init();
  }

  void _init() async{
    WidgetsFlutterBinding.ensureInitialized();

    if(EnvType.DEVELOPMENT == environmentType || EnvType.STAGING == environmentType){
      Stetho.initialize();
    }

    var application = AppStoreApplication();
    await application.onCreate();
    runApp(AppComponent(application));
  }
}