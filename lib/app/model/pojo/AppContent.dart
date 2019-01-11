import 'package:flutter_starter_kit/app/model/pojo/Entry.dart';
import 'package:flutter_starter_kit/app/model/pojo/Property.dart';
import 'package:json_annotation/json_annotation.dart';

part 'AppContent.g.dart';

@JsonSerializable()
class AppContent{

  // Primary Key
  num trackId;
  int isFeatureApp;
  int isFreeApp;
  String trackName;
  String description;
  int order;


  bool isGameCenterEnabled;
  List<String> screenshotUrls;
  List<String> ipadScreenshotUrls;
  List<String> appletvScreenshotUrls;
  String artworkUrl60;
  String artworkUrl512;
  String artworkUrl100;
  String artistViewUrl;
  List<String> supportedDevices;
  String kind;
  List<String> features;
  List<String> advisories;
  String contentAdvisoryRating;
  String trackViewUrl;
  String trackCensoredName;
  List<String> languageCodesISO2A;
  String fileSizeBytes;
  String trackContentRating;
  String formattedPrice;
  String sellerName;
  String currentVersionReleaseDate;
  bool isVppDeviceBasedLicensingEnabled;
  String releaseNotes;
  String releaseDate;
  num primaryGenreId;
  String currency;
  String wrapperType;
  String version;
  String minimumOsVersion;
  String primaryGenreName;
  List<String> genreIds;
  num artistId;
  String artistName;
  List<String> genres;
  double price;
  String bundleId;
  double averageUserRating;
  num userRatingCount;


  AppContent(this.isGameCenterEnabled, this.screenshotUrls,
      this.ipadScreenshotUrls, this.appletvScreenshotUrls, this.artworkUrl60,
      this.artworkUrl512, this.artworkUrl100, this.artistViewUrl,
      this.supportedDevices, this.kind, this.features, this.advisories,
      this.contentAdvisoryRating, this.trackViewUrl, this.trackCensoredName,

      this.languageCodesISO2A, this.fileSizeBytes, this.trackContentRating,

      this.formattedPrice, this.sellerName, this.currentVersionReleaseDate,

      this.isVppDeviceBasedLicensingEnabled, this.trackId, this.trackName,
      this.releaseNotes, this.releaseDate, this.primaryGenreId, this.currency,
      this.wrapperType, this.version, this.minimumOsVersion,
      this.primaryGenreName, this.genreIds, this.description, this.artistId,
      this.artistName, this.genres, this.price, this.bundleId,
      this.averageUserRating, this.userRatingCount);


  AppContent.init(this.trackId, this.trackName, this.artworkUrl100);

  factory AppContent.fromEntry(Entry entry) {
    String artworkUrl100;
    String artworkUrl60;
    for(Property property in entry.imImage){
      if(property.attributes.height.contains("100")){
        artworkUrl100 = property.label;
      }
      else if(null == artworkUrl60 && (property.attributes.height.contains("53") || property.attributes.height.contains("75"))){
        artworkUrl60 = property.label;
      }
    }

    String trackName = entry.imName.label;
    String trackCensoredName = entry.imName.label;
    num trackId = num.parse(entry.id.attributes.imId);
    String bundleId = entry.id.attributes.imBundleId;
    String description = entry.summary.label;
    double price = double.parse(entry.imPrice.attributes.amount);
    String currency = entry.imPrice.attributes.currency;
    num primaryGenreId = num.parse(entry.category.attributes.imId); // number
    String trackViewUrl = entry.link.attributes.href;
    String artistName = entry.imArtist.label;
    String artistViewUrl = null != entry.imArtist.attributes ? entry.imArtist.attributes.href : null;
    List<String> genres = [entry.category.attributes.label];
    String releaseDate = entry.imReleaseDate.label;
    return AppContent(null, null,
      null, null, artworkUrl60,
      null, artworkUrl100, artistViewUrl,
      null, null, null, null,
      null, trackViewUrl, trackCensoredName,
      null, null, null,
      null, null, null,
      null, trackId, trackName,
      null, releaseDate, primaryGenreId, currency,
      null, null, null,
      null, null, description, null,
      artistName, genres, price, bundleId,
      null, null);
  }


  factory AppContent.fromJson(Map<String, dynamic> json) => _$AppContentFromJson(json);

  Map<String, dynamic> toJson() => _$AppContentToJson(this);

}