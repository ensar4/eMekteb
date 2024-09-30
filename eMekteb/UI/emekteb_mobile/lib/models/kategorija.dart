
import 'package:json_annotation/json_annotation.dart';

part 'kategorija.g.dart';

@JsonSerializable()
class Kategorija{
  int? id;
  String? naziv;
  String? nivo;
  int? takmicenjeId;


  Kategorija(
      this.id,
      this.naziv,
      this.nivo,
      this.takmicenjeId
      );
  factory Kategorija.fromJson(Map<String, dynamic> json) => _$KategorijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KategorijaToJson(this);
}
