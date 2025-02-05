import 'package:json_annotation/json_annotation.dart';

part 'medzlis.g.dart';

@JsonSerializable()
class Medzlis{
  int? id;
  String? naziv;
  String? adresa;
  String? telefon;
  String? mail;
  int? ukupnoMekteba;
  int? ukupnoUcenika;
  double? prosjecnaOcjena;
  double? prosjecnoPrisustvo;
  int? muftijstvoId;

  Medzlis(
      this.id,
      this.naziv,
      this.adresa,
      this.telefon,
      this.mail,
      this.ukupnoMekteba,
      this.ukupnoUcenika,
      this.prosjecnaOcjena,
      this.prosjecnoPrisustvo,
      this.muftijstvoId
      );

  factory Medzlis.fromJson(Map<String, dynamic> json) => _$MedzlisFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MedzlisToJson(this);
}

