import 'package:flutter_starter_kit/app/model/pojo/Property.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Entry.g.dart';

@JsonSerializable()
class Entry{


  @JsonKey(name: 'im:name')
  Property imName;
  @JsonKey(name: 'im:image')
  List<Property> imImage;
  Property summary;
  @JsonKey(name: 'im:price')
  Property imPrice;
  @JsonKey(name: 'im:contentType')
  Property imContentType;
  Property title;
  List<Property> link;
  Property id;
  @JsonKey(name: 'im:artist')
  Property imArtist;
  Property category;
  @JsonKey(name: 'im:releaseDate')
  Property imReleaseDate;


  Entry(this.imName, this.imImage, this.summary, this.imPrice,
      this.imContentType, this.title, this.link, this.id, this.imArtist,
      this.category, this.imReleaseDate);

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

  Map<String, dynamic> toJson() => _$EntryToJson(this);

}