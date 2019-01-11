import 'dart:async';

import 'package:flutter_starter_kit/app/model/core/AppStoreApplication.dart';
import 'package:flutter_starter_kit/app/model/pojo/AppContent.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class AppDetailBloc{
  final AppStoreApplication _application;
  CompositeSubscription _compositeSubscription = CompositeSubscription();

  final _isShowLoading = BehaviorSubject<bool>();
  final _appContent = BehaviorSubject<AppContent>();

  Stream<bool> get isShowLoading => _isShowLoading.stream;
  Stream<AppContent> get appContent => _appContent.stream;


  AppDetailBloc(this._application);

  void dispose() {
    _compositeSubscription.clear();
    _isShowLoading.close();
    _appContent.close();
  }

  void loadDetail(String appId){
    _isShowLoading.add(true);
    StreamSubscription subscription = _application.appStoreAPIRepository.getAppDetail(appId)
        .listen((AppContent appContent){
      _appContent.add(appContent);
      _isShowLoading.add(false);
    });
    _compositeSubscription.add(subscription);
  }

}