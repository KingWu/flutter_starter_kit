import 'dart:async';

import 'package:flutter_starter_kit/app/model/api/AppStoreAPIRepository.dart';
import 'package:flutter_starter_kit/app/model/core/AppStoreApplication.dart';
import 'package:flutter_starter_kit/app/model/pojo/AppContent.dart';
import 'package:flutter_starter_kit/utility/log/Log.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc{
  static const int FORCE_LOAD_NUMBER = 10;
  static const int THRESHOLD_LOAD_ITEM = 3;


  final AppStoreApplication _application;
  final _searchText = BehaviorSubject<String>();
  final _feedList = BehaviorSubject<List<HomeListItem>>();
  final _isShowLoading = BehaviorSubject<bool>();
  List<HomeListItem> appList;

  HomeBloc(this._application){
    _init();
  }

  CompositeSubscription _compositeSubscription = CompositeSubscription();
  Stream<bool> get isShowLoading => _isShowLoading.stream;
  Stream<String> get searchText => _searchText.stream;
  Stream<List<HomeListItem>> get feedList => _feedList.stream;

  var loadedMap = {};

  void _init(){
    // Debounce search text
    _searchText.debounce(const Duration(milliseconds: 500))
    .listen((String searchText){
      _searchApps(searchText);
    });
  }

  void dispose() {
    _compositeSubscription.clear();
    _searchText.close();
    _feedList.close();
    _isShowLoading.close();
  }

  void changeSearchText(String searchTxt){
    _searchText.add(searchTxt);
  }

  void loadFeedList(){
    _isShowLoading.add(true);
    AppStoreAPIRepository apiProvider = _application.appStoreAPIRepository;

    StreamSubscription subscription = Observable.fromFuture(_application.dbAppStoreRepository.deleteAllAppContent())
        .flatMap((_) => apiProvider.getTop10FeatureApp())
        .zipWith(apiProvider.getTop100FreeApp(), (List<AppContent> featureApps, List<AppContent> freeApps){
          return CombinedAppResponse(featureApps, freeApps);
        })
        .listen((CombinedAppResponse response){
          if(null != appList){
            appList.clear();
          }
          appList = List<HomeListItem>();

          appList.add(FeatureListItem(response.featureApps));

          List<AppContent> entries = response.freeApps;

          for(var i = 0 ; i < entries.length ; i++){
            appList.add(TopAppListItem(entries[i]));
          }
          _feedList.add(appList);
          _isShowLoading.add(false);
          _forceLoadListItem(FORCE_LOAD_NUMBER);
        },
        onError: (e, s){
          Log.info(e);
        });
    _compositeSubscription.add(subscription);
  }

  void handleOnScroll(List<int> visibleIndex){
    if(visibleIndex.length > 0){
      int lastIndex = visibleIndex[visibleIndex.length - 1];
      int preShowLastIndex = lastIndex + THRESHOLD_LOAD_ITEM;
      for(var index = visibleIndex[0] ; index <= preShowLastIndex ; index++ ){
        _loadDetailInfo(index);
      }
    }
  }

  void _searchApps(String searchKey){
    StreamSubscription subscription = Observable.fromFuture(_application.dbAppStoreRepository.loadFeaturesApp(searchKey))
      .zipWith(Observable.fromFuture(_application.dbAppStoreRepository.loadTopFreeApp(searchKey)), (List<AppContent> featureApps, List<AppContent> freeApps){
      return CombinedAppResponse(featureApps, freeApps);
    })
    .listen((CombinedAppResponse response){
      appList.clear();

      if(response.featureApps.length > 0){
        appList.add(FeatureListItem(response.featureApps));
      }

      if(response.freeApps.length > 0){
        List<AppContent> entries = response.freeApps;
        for(var i = 0 ; i < entries.length ; i++){
          appList.add(TopAppListItem(entries[i]));
        }
      }
      _feedList.add(appList);
    },
    onError: (e, s){
      Log.info(e);
    });
    _compositeSubscription.add(subscription);
  }

  void _loadDetailInfo(int index){
    if(appList.length == 0 || appList.length <= index){
      return;
    }

    HomeListItem listItem = appList[index];

    if(HomeListType.TYPE_TOP_APP == listItem.type){
      TopAppListItem freeAppListItem = listItem;

      if(null != loadedMap[freeAppListItem.entry.trackId] && loadedMap[freeAppListItem.entry.trackId]){
        return;
      }

      loadedMap[freeAppListItem.entry.trackId] = true;

      StreamSubscription subscription = _application.appStoreAPIRepository.getAppDetail(freeAppListItem.entry.trackId.toString())
          .listen((AppContent appContent){
        freeAppListItem.entry = appContent;
        _feedList.add(appList);
      });
      _compositeSubscription.add(subscription);
    }
  }

  void _forceLoadListItem(int number){
    for(var i = 0 ; i < number; i++){
      _loadDetailInfo(i);
    }
  }
}

class CombinedAppResponse{
  List<AppContent> featureApps;
  List<AppContent> freeApps;

  CombinedAppResponse(this.featureApps, this.freeApps);
}

enum HomeListType {
  TYPE_FEATURE,
  TYPE_TOP_APP
}

class HomeListItem {
  HomeListType type;

  HomeListItem(this.type);
}

class FeatureListItem extends HomeListItem{
  List<AppContent> entryList;

  FeatureListItem(this.entryList) : super(HomeListType.TYPE_FEATURE);
}

class TopAppListItem extends HomeListItem {
  AppContent entry;
  TopAppListItem(this.entry) : super(HomeListType.TYPE_TOP_APP);
}