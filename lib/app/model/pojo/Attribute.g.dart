// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attribute _$AttributeFromJson(Map<String, dynamic> json) {
  return Attribute(
    json['height'] as String,
    json['amount'] as String,
    json['currency'] as String,
    json['term'] as String,
    json['rel'] as String,
    json['type'] as String,
    json['href'] as String,
    json['im:id'] as String,
    json['im:bundleId'] as String,
    json['scheme'] as String,
    json['label'] as String,
  );
}

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
      'height': instance.height,
      'amount': instance.amount,
      'currency': instance.currency,
      'term': instance.term,
      'rel': instance.rel,
      'type': instance.type,
      'href': instance.href,
      'im:id': instance.imId,
      'im:bundleId': instance.imBundleId,
      'scheme': instance.scheme,
      'label': instance.label,
    };
