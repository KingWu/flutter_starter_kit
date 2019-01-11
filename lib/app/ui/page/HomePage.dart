import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/bloc/HomeBloc.dart';
import 'package:flutter_starter_kit/app/model/core/AppProvider.dart';
import 'package:flutter_starter_kit/app/model/pojo/AppContent.dart';
import 'package:flutter_starter_kit/app/ui/page/AppDetailPage.dart';
import 'package:flutter_starter_kit/generated/i18n.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class HomePage extends StatefulWidget {
  static const String PATH = '/';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeBloc bloc;
  final TextEditingController _searchBoxController = new TextEditingController();
  Color greyColor = Color.fromARGB(255, 163, 163, 163);
  var _keys = {};
  var listViewKey = RectGetter.createGlobalKey();

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _init();

    return Scaffold(
      appBar: AppBar(
        title: buildSearchBar()
      ),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          bloc.handleOnScroll(_getVisibleItem());
          return true;
        },
        child: buildFeedList(),
      )
    );
  }

  Widget buildSearchBar(){
    return StreamBuilder(
      stream: bloc.searchText,
      builder: (context, snapshot) {
        String searchText = snapshot.data;

        return TextField(
          controller: _searchBoxController,
          onChanged: bloc.changeSearchText,
          decoration: InputDecoration(
              fillColor: Colors.white70,
              filled: true,
              hasFloatingPlaceholder: false,
              prefixIcon: Icon(Icons.search),
              suffixIcon: null != searchText && searchText.isNotEmpty ? IconButton(
                icon:Icon(Icons.clear),
                onPressed: () {
                  _searchBoxController.clear();
                  bloc.changeSearchText('');
                },
              ) : null,
              border: InputBorder.none,
              hintText: S.of(context).homeSearchHint
          ),
        );
      },
    );
  }

  void _init(){
    if(null == bloc){
      bloc = HomeBloc(AppProvider.getApplication(context));
      bloc.isShowLoading.listen((bool isLoading){
        if(isLoading){
          _showLoading();
        }
        else{
          Navigator.pop(context);
        }
      });
      bloc.loadFeedList();
    }
  }

  void _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        child: Dialog(
            child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(S.of(context).dialogLoading)
                    )
                  ],
                )
            )
        )
    );
  }

  List<int> _getVisibleItem() {
    var rect = RectGetter.getRectFromKey(listViewKey);
    var _items = <int>[];
    _keys.forEach((index, key) {
      var itemRect = RectGetter.getRectFromKey(key);

      if (itemRect != null && !(itemRect.top > rect.bottom || itemRect.bottom < rect.top)) _items.add(index);
    });
    return _items;
  }

  Widget buildFeedList(){
    return StreamBuilder(
      stream: bloc.feedList,
      builder: (context, snapshot) {
        List<HomeListItem> feedList = snapshot.data;
        return RectGetter(
          key: listViewKey,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: null != feedList ? feedList.length : 0,
              itemBuilder: (context, index) {
                if(null == _keys[index]){
                  _keys[index] = RectGetter.createGlobalKey();
                }

                var key = _keys[index];

                HomeListItem listItem = feedList[index];

                if(HomeListType.TYPE_FEATURE == listItem.type){
                  return RectGetter(
                    key: key,
                    child: buildFeatureListItem(listItem),
                  );
                }

                if(HomeListType.TYPE_FEATURE == feedList[0].type){
                  index -= 1;
                }

                return RectGetter(
                  key: key,
                  child: buildTopAppListItem(listItem, index),
                );
              }
          ),
        );
      }
    );
  }

  Widget buildFeatureListItem(FeatureListItem featureListItem){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, top: 12, bottom: 16),
          child: Text(
              S.of(context).homeRecommend,
              style: Theme.of(context).textTheme.title,
          ),
        ),
        Container(
          height: 160,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featureListItem.entryList.length,
              itemBuilder: (context, index) {
                AppContent app = featureListItem.entryList[index];
                String name = app.trackName;
                String category = app.genres[0];
                String heroTag = 'featureAppIcon_$index';
                String titleTag = 'featureAppTitle_$index';

                return Container(
                  width: 85,
                  margin: EdgeInsets.only(left: 16, right: index == featureListItem.entryList.length - 1 ? 16 : 0),
                  child: InkWell(
                    onTap: (){
                      AppProvider.getRouter(context).navigateTo(context, AppDetailPage.generatePath(app.trackId, heroTag, titleTag, name, app.artworkUrl100), transition: TransitionType.fadeIn);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 85,
                          margin: EdgeInsets.only(bottom: 8),
                          child: Hero(
                            tag: 'featureAppIcon_$index',
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CachedNetworkImage(
                                    imageUrl: app.artworkUrl100,
                                    errorWidget: new Icon(Icons.error),
                                    fadeOutDuration: new Duration(seconds: 1),
                                    fadeInDuration: new Duration(seconds: 1)
                                )
                            ),
                          )
                        ),
                        Hero(
                          tag: titleTag,
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )
                        ),
                        Text(
                          category,
                          maxLines: 1,
                          style: TextStyle(
                              color: greyColor
                          ),
                        ),
                      ],
                    )
                  )
                );
              }
          )
        ),
        Divider(height: 4, color: greyColor)
      ],
    );
  }

  Widget buildTopAppListItem(TopAppListItem listItem, int index){
    AppContent app = listItem.entry;
    String name = app.trackName;
    String category = app.genres[0];
    double rating = null != app.averageUserRating ? app.averageUserRating : 0.0;
    num userCount = null != app.userRatingCount ? app.userRatingCount : 0;

    int order = index + 1;
    String heroTag = 'freeAppIcon_$order';
    String titleTag = 'freeAppTitle_$order';

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            onTap: (){
              AppProvider.getRouter(context).navigateTo(context, AppDetailPage.generatePath(app.trackId, heroTag, titleTag, name, app.artworkUrl100), transition: TransitionType.fadeIn);
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 20, right: 5),
                    width: 40,
                    child:  Text(
                      "$order",
                      style: Theme.of(context).textTheme.title,
                    )
                ),
                Container(
                  height: 70,
                  width:  70,
                  child: Hero(
                    tag: heroTag,
                    child: buildAppIcon(index, app.artworkUrl100)
                  )
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Hero(
                              tag: titleTag,
                              child: Text(
                                  name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1
                              ),
                            ),
                            Text(
                              category,
                              maxLines: 1,
                              style: TextStyle(
                                  color: greyColor
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                SmoothStarRating(
                                  allowHalfRating: false,
                                  starCount: 5,
                                  rating: rating,
                                  size: 15.0,
                                  color: Colors.orange,
                                  borderColor: Colors.orange,
                                ),
                                Text(
                                    "($userCount)"
                                )
                              ],
                            )

                          ],
                        )
                    )
                )

              ],
            )
          )
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Divider(height: 4, color: greyColor),
        )
      ],
    );

  }

  Widget buildAppIcon(int index, String iconUrl){
    BorderRadius radius;
    if(0 == index % 2){
      // Rounded
      radius = BorderRadius.circular(16.0);
    }
    else{
      // Circle
      radius = BorderRadius.circular(35.0);
    }

    return ClipRRect(
        borderRadius: radius,
        child: CachedNetworkImage(
            imageUrl: iconUrl,
            errorWidget: new Icon(Icons.error),
            fadeOutDuration: new Duration(seconds: 1),
            fadeInDuration: new Duration(seconds: 1)
        )
    );
  }


}