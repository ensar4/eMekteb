
import 'package:json_annotation/json_annotation.dart';

part 'kamp.g.dart';

@JsonSerializable()
class Kamp{
  int? id;
  String naziv;
  String? opis;
  DateTime datumPocetka;
  DateTime datumZavrsetka;
  String? voditelj;
  int? mektebId;


  Kamp(this.id,
      this.naziv,
      this.opis,
      this.datumPocetka,
      this.datumZavrsetka,
      this.voditelj,
      this.mektebId
      );
  factory Kamp.fromJson(Map<String, dynamic> json) => _$KampFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$KampToJson(this);
}
