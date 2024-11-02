import 'package:json_annotation/json_annotation.dart';


part 'dodatna_lekcija.g.dart';

@JsonSerializable()

class DodatnaLekcija{
  int? id;
  String naziv;
  String tekst;
  int? likes;
  int? dislikes;
  DateTime? datumObjavljivanja;
  int? mektebId;

  DodatnaLekcija(
      this.id,
      this.naziv,
      this.tekst,
      this.mektebId,
      this.likes,
      this.dislikes,
      );
  factory DodatnaLekcija.fromJson(Map<String, dynamic> json) => _$DodatnaLekcijaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$DodatnaLekcijaToJson(this);
}