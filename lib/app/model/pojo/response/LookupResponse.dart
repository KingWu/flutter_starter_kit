import 'package:flutter_starter_kit/app/model/pojo/AppContent.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LookupResponse.g.dart';

@JsonSerializable()
class LookupResponse{

  int resultCount;
  List<AppContent> results;


  LookupResponse(this.resultCount, this.results);

  factory LookupResponse.fromJson(Map<String, dynamic> json) => _$LookupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LookupResponseToJson(this);

}
