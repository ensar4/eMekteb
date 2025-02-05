import 'package:json_annotation/json_annotation.dart';


part 'ucenik.g.dart';

@JsonSerializable()

class Ucenik{
  int? id;
  String? ime;
  String? prezime;
  String? telefon;
  String? mail;
  String? username;
  String? status;
  String? spol;
  DateTime? datumRodjenja;
  String? imeRoditelja;
  int? mektebId;
  int? idRazreda;
  String? nazivRazreda;
  double? prisustvo;
  double? prosjek;
  double? ocjena;

  Ucenik(this.id,
      this.ime,
      this.telefon,
      this.mail,
      this.prezime,
      this.username,
      this.imeRoditelja,
      this.mektebId,
      this.status,
      this.spol,
      this.idRazreda,
      this.datumRodjenja,
      this.prisustvo,
      this.prosjek,
      this.nazivRazreda,
      this.ocjena,
      );
  factory Ucenik.fromJson(Map<String, dynamic> json) => _$UcenikFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UcenikToJson(this);
}