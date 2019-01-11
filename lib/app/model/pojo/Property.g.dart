// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) {
  return Property(
      json['label'] as String,
      json['attributes'] == null
          ? null
          : Attribute.fromJson(json['attributes'] as Map<String, dynamic>));
}

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'label': instance.label,
      'attributes': instance.attributes
    };
