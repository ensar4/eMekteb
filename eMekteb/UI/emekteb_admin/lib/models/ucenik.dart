import 'package:json_annotation/json_annotation.dart';


part 'ucenik.g.dart';

@JsonSerializable()

class Ucenik{
  int? id;
  String? ime;
  String? prezime;
  String? telefon;
  String? status;
  DateTime? datumRodjenja;
  String? imeRoditelja;
  String? nazivRazreda;
  int? mektebId;
  int? razredId;
  double? prisustvo;
  double? prosjek;

  Ucenik(this.id,
      this.ime,
      this.telefon,
      this.prezime,
      this.imeRoditelja,
      this.mektebId,
      this.status,
      this.razredId,
      this.datumRodjenja,
      this.prisustvo,
      this.prosjek,
      this.nazivRazreda,
      );
  factory Ucenik.fromJson(Map<String, dynamic> json) => _$UcenikFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UcenikToJson(this);
}