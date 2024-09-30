import 'package:json_annotation/json_annotation.dart';

part 'akademska_godina.g.dart';

@JsonSerializable()
class AkademskaGodina{
  int? id;
  String? naziv;
  DateTime? datumPocetka;
  DateTime? datumZavrsetka;
  int? ukupnoMekteba;
  int? ukupnoUcenika;
  double? prosjecnaOcjena;
  double? prosjecnoPrisustvo;

  AkademskaGodina(this.id,
      this.naziv,
      this.datumPocetka,
      this.datumZavrsetka,
      this.ukupnoMekteba,
      this.ukupnoUcenika,
      this.prosjecnaOcjena,
      this.prosjecnoPrisustvo
      );

  factory AkademskaGodina.fromJson(Map<String, dynamic> json) => _$AkademskaGodinaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AkademskaGodinaToJson(this);
}

