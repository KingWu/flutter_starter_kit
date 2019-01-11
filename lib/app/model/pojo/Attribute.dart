import 'package:json_annotation/json_annotation.dart';

part 'Attribute.g.dart';

@JsonSerializable()
class Attribute{

  String height;
  String amount;
  String currency;
  String term;
  String rel;
  String type;
  String href;
  @JsonKey(name: 'im:id')
  String imId;
  @JsonKey(name: 'im:bundleId')
  String imBundleId;
  String scheme;
  String label;




  Attribute(this.height, this.amount, this.currency, this.term, this.rel,
      this.type, this.href, this.imId, this.imBundleId, this.scheme,
      this.label);

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeToJson(this);

}