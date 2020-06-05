// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TopAppResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopAppResponse _$TopAppResponseFromJson(Map<String, dynamic> json) {
  return TopAppResponse(
    json['feed'] == null
        ? null
        : Feed.fromJson(json['feed'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TopAppResponseToJson(TopAppResponse instance) =>
    <String, dynamic>{
      'feed': instance.feed,
    };

Feed _$FeedFromJson(Map<String, dynamic> json) {
  return Feed(
    (json['entry'] as List)
        ?.map(
            (e) => e == null ? null : Entry.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
      'entry': instance.entry,
    };
