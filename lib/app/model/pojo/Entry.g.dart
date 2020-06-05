// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return Entry(
    json['im:name'] == null
        ? null
        : Property.fromJson(json['im:name'] as Map<String, dynamic>),
    (json['im:image'] as List)
        ?.map((e) =>
            e == null ? null : Property.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['summary'] == null
        ? null
        : Property.fromJson(json['summary'] as Map<String, dynamic>),
    json['im:price'] == null
        ? null
        : Property.fromJson(json['im:price'] as Map<String, dynamic>),
    json['im:contentType'] == null
        ? null
        : Property.fromJson(json['im:contentType'] as Map<String, dynamic>),
    json['title'] == null
        ? null
        : Property.fromJson(json['title'] as Map<String, dynamic>),
    (json['link'] as List)
        ?.map((e) =>
            e == null ? null : Property.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['id'] == null
        ? null
        : Property.fromJson(json['id'] as Map<String, dynamic>),
    json['im:artist'] == null
        ? null
        : Property.fromJson(json['im:artist'] as Map<String, dynamic>),
    json['category'] == null
        ? null
        : Property.fromJson(json['category'] as Map<String, dynamic>),
    json['im:releaseDate'] == null
        ? null
        : Property.fromJson(json['im:releaseDate'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'im:name': instance.imName,
      'im:image': instance.imImage,
      'summary': instance.summary,
      'im:price': instance.imPrice,
      'im:contentType': instance.imContentType,
      'title': instance.title,
      'link': instance.link,
      'id': instance.id,
      'im:artist': instance.imArtist,
      'category': instance.category,
      'im:releaseDate': instance.imReleaseDate,
    };
