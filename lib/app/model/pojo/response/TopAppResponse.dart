import 'package:flutter_starter_kit/app/model/pojo/Entry.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TopAppResponse.g.dart';

@JsonSerializable()
class TopAppResponse{

  Feed feed;

  TopAppResponse(this.feed);

  factory TopAppResponse.fromJson(Map<String, dynamic> json) => _$TopAppResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopAppResponseToJson(this);

}

@JsonSerializable()
class Feed{
  List<Entry> entry;

  Feed(this.entry);

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);

  Map<String, dynamic> toJson() => _$FeedToJson(this);

}