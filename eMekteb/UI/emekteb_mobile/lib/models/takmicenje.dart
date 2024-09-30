
import 'package:json_annotation/json_annotation.dart';

part 'takmicenje.g.dart';

@JsonSerializable()
class Takmicenje{
  int? id;
  String godina;
  DateTime datumOdrzavanja;
  String lokacija;
  String? vrijemePocetka;
  String info;
  int medzlisId;


  Takmicenje(this.id,
      this.godina,
      this.datumOdrzavanja,
      this.lokacija,
      this.vrijemePocetka,
      this.info,
      this.medzlisId
      );
  factory Takmicenje.fromJson(Map<String, dynamic> json) => _$TakmicenjeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TakmicenjeToJson(this);
}
