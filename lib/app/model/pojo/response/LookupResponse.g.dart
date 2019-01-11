// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LookupResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookupResponse _$LookupResponseFromJson(Map<String, dynamic> json) {
  return LookupResponse(
      json['resultCount'] as int,
      (json['results'] as List)
          ?.map((e) =>
              e == null ? null : AppContent.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LookupResponseToJson(LookupResponse instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'results': instance.results
    };
