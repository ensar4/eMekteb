import 'package:json_annotation/json_annotation.dart';

part 'muftijstvo.g.dart';

@JsonSerializable()
class Muftijstvo{
  int? id;
  String? naziv;
  String? adresa;
  String? telefon;
  String? mail;
  int? ukupnoMekteba;
  int? ukupnoUcenika;
  double? prosjecnaOcjena;
  double? prosjecnoPrisustvo;

  Muftijstvo(this.id,
      this.naziv,
      this.adresa,
      this.telefon,
      this.mail,
      this.ukupnoMekteba,
      this.ukupnoUcenika,
      this.prosjecnaOcjena,
      this.prosjecnoPrisustvo
      );

  factory Muftijstvo.fromJson(Map<String, dynamic> json) => _$MuftijstvoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MuftijstvoToJson(this);
}

