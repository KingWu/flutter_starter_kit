import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/bloc/AppDetailBloc.dart';
import 'package:flutter_starter_kit/app/model/core/AppProvider.dart';
import 'package:flutter_starter_kit/app/model/pojo/AppContent.dart';
import 'package:flutter_starter_kit/generated/i18n.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AppDetailPage extends StatefulWidget {
  static const String PATH = '/detail';
  final num appId;
  final String title;
  final String url;
  final String heroTag;
  final String titleTag;

  AppDetailPage({Key key, this.appId, this.title, this.url, this.heroTag, this.titleTag}) : super(key: key);

  static String generatePath(num appId, String heroTag, String titleTag, String title, String url){
    Map<String, dynamic> parma = {
      'appId': appId.toString(),
      'heroTag': heroTag,
      'title': title,
      'url': url,
      'titleTag': titleTag
    };
    Uri uri = Uri(path: PATH, queryParameters: parma);
    return uri.toString();
  }

  @override
  _AppDetailPageState createState() => _AppDetailPageState();
}


class _AppDetailPageState extends State<AppDetailPage> {

  AppContent _initAppContent;

  AppDetailBloc appDetailBloc;
  Color greyColor = Color.fromARGB(255, 163, 163, 163);

  @override
  void initState() {
    super.initState();
    _initAppContent = AppContent.init(widget.appId, widget.title, widget.url);
  }

  @override
  void dispose() {
    super.dispose();
    appDetailBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _init(context);

    return StreamBuilder(
        stream: appDetailBloc.appContent,
        initialData: _initAppContent,
        builder: (context, snapshot){
          AppContent appContent = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                  title: Text(appContent.trackName)
              ),
              body: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildAppContent(context, appContent),
                        Divider(height: 4, color: greyColor),
                        buildRatingSection(context, appContent),
                        Divider(height: 4, color: greyColor),
                        buildGallerySection(context, appContent),
                        buildSummarySection(context, appContent)
                      ]
                  )
              )
          );
        }
    );
  }

  void _showLoading(BuildContext context) {
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

  void _init(BuildContext context){
    if(null == appDetailBloc){
      appDetailBloc = AppDetailBloc(AppProvider.getApplication(context));
      appDetailBloc.isShowLoading.listen((bool isLoading){
        if(isLoading){
          _showLoading(context);
        }
        else{
          Navigator.pop(context);
        }
      });
      appDetailBloc.loadDetail(widget.appId.toString());

    }
  }

  Widget buildAppContent(BuildContext context, AppContent appContent){

    List<String> category = appContent.genres;
    List<Widget> chips = [];
    if(null != category){
      for(String c in category){
        chips.add(Chip(
            label: Text(c)
        ));
      }
    }
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 100,
              width:  100,
              margin: EdgeInsets.only(right: 12),
              child: Hero(
                  tag: widget.heroTag,
                  child: buildAppIcon(appContent.artworkUrl100)
              )
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: widget.titleTag,
                  child: Text(
                    appContent.trackName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.title,
                  )
                ),
                Text(
                  null != appContent.artistName ? appContent.artistName : '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.green
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  children: chips
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget buildRatingSection(BuildContext context, AppContent appContent){
    num userRatingCount = null != appContent.userRatingCount ? appContent.userRatingCount : 0;
    num averageUserRating = null != appContent.averageUserRating ? appContent.averageUserRating : 0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '$averageUserRating',
                style: Theme.of(context).textTheme.display1,
              ),
              Container(
                width: 4,
              ),
              SmoothStarRating(
                starCount: 1,
                rating: 1,
                size: 35.0,
                color: Colors.orange,
                borderColor: Colors.orange,
              )
            ]
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  '$userRatingCount'
              ),
              Container(
                width: 4,
              ),
              Text(
                  S.of(context).detailRate
              )
            ],
          )
        ],
      )
    );
  }

  Widget buildGallerySection(BuildContext context, AppContent appContent){
    int length = null != appContent.screenshotUrls ? appContent.screenshotUrls.length : 0;

    return Container(
      height: 300,
      margin: EdgeInsets.only(top: 12),
      child: ListView.separated(
        itemCount: length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context int index){
          return Container(width: 12);
        },
        itemBuilder: (BuildContext context int index){
          double left = 0 == index ? 20 : 0;
          double right = length - 1 == index ? 20 : 0;
          String url = appContent.screenshotUrls[index];
          return Container(
            margin: EdgeInsets.only(left: left, right: right),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.fitHeight,
              errorWidget: new Icon(Icons.error),
              fadeOutDuration: new Duration(seconds: 1),
              fadeInDuration: new Duration(seconds: 1)
            )
          );
        }
      )
    );
  }

  Widget buildSummarySection(BuildContext context, AppContent appContent){
    String description = null != appContent.description ? appContent.description : '';
    return Container(
      padding: EdgeInsets.all(12),
      child: Text(
        description
      )
    );
  }

  Widget buildAppIcon(String iconUrl){

    return ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: CachedNetworkImage(
            imageUrl: iconUrl,
            errorWidget: new Icon(Icons.error),
            fadeOutDuration: new Duration(seconds: 1),
            fadeInDuration: new Duration(seconds: 1)
        )
    );
  }
}
