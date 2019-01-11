import 'package:flutter_starter_kit/app/model/pojo/Attribute.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Property.g.dart';

@JsonSerializable()
class Property{


  String label;
  Attribute attributes;

  Property(this.label, this.attributes);

  factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);

}