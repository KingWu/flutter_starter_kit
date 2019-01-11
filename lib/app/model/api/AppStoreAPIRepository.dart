import 'package:flutter_starter_kit/app/model/api/APIProvider.dart';
import 'package:flutter_starter_kit/app/model/db/DBAppStoreRepository.dart';
import 'package:flutter_starter_kit/app/model/pojo/AppContent.dart';
import 'package:flutter_starter_kit/app/model/pojo/Entry.dart';
import 'package:flutter_starter_kit/app/model/pojo/response/LookupResponse.dart';
import 'package:flutter_starter_kit/app/model/pojo/response/TopAppResponse.dart';
import 'package:flutter_starter_kit/utility/log/Log.dart';
import 'package:rxdart/rxdart.dart';

class AppStoreAPIRepository{
  static const int TOP_100 = 100;
  static const int TOP_10 = 10;

  APIProvider _apiProvider;
  DBAppStoreRepository _dbAppStoreRepository;

  AppStoreAPIRepository(this._apiProvider, this._dbAppStoreRepository);


  Observable<List<AppContent>> getTop100FreeApp(){
    return Observable.fromFuture(_apiProvider.getTopFreeApp(TOP_100))
    .flatMap(_convertFromEntry)
    .flatMap((List<AppContent> list){
      return Observable.fromFuture(_loadAndSaveTopFreeApp(list, ''));
    });
  }

  Observable<List<AppContent>> getTop10FeatureApp(){
    return Observable.fromFuture(_apiProvider.getTopFeatureApp(TOP_10))
    .flatMap(_convertFromEntry)
    .flatMap((List<AppContent> list){
      return Observable.fromFuture(_loadAndSaveFeatureApp(list, ''));
    });
  }

  Observable<AppContent> getAppDetail(String id){
    return Observable.fromFuture(_apiProvider.getAppDetail(id))
    .flatMap((LookupResponse response){
      return Observable.just(response.results[0]);
    })
    .flatMap((AppContent appContent){
      return Observable.fromFuture(_loadAndSaveAppDetail(appContent));
    });
  }


  Observable<List<AppContent>> _convertFromEntry(TopAppResponse response){
    List<AppContent> appContent = [];
    for(Entry entry in response.feed.entry){
      appContent.add(AppContent.fromEntry(entry));
    }
    return Observable.just(appContent);
  }

  Future<List<AppContent>> _loadAndSaveFeatureApp(List<AppContent> list, String searchKey) async{
    for(var i = 0; i < list.length ; i++){
      AppContent app = list[i];
      app.order = i;
      app.isFeatureApp = 1;
      await _dbAppStoreRepository.saveOrUpdateFeatureApp(app);
    }
    List<AppContent> appList = await _dbAppStoreRepository.loadFeaturesApp(searchKey);
    return appList;
  }

  Future<List<AppContent>> _loadAndSaveTopFreeApp(List<AppContent> list, String searchKey) async{
    for(var i = 0; i < list.length ; i++){
      AppContent app = list[i];
      app.order = i;
      app.isFreeApp = 1;
      await _dbAppStoreRepository.saveOrUpdateTopFreeApp(app);
    }
    List<AppContent> appList = await _dbAppStoreRepository.loadTopFreeApp(searchKey);
    return appList;
  }

  Future<AppContent> _loadAndSaveAppDetail(AppContent appContent) async{
    await _dbAppStoreRepository.saveOrUpdateDetailApp(appContent);
    AppContent appDb = await _dbAppStoreRepository.loadAppDetail(appContent.trackId);
    return appDb;
  }

}