import 'package:json_annotation/json_annotation.dart';


part 'mualim.g.dart';

@JsonSerializable()

class Mualim{
  int? id;
  String? ime;
  String? prezime;
  String? username;
  String? telefon;
  String? status;
  String? mail;
  String? spol;
  String? imeRoditelja;
  DateTime? datumRodjenja;
  int? mektebId;


  Mualim(
      this.id,
      this.ime,
      this.telefon,
      this.prezime,
      this.mektebId,
      this.status,
      this.datumRodjenja,
      this.username,
      this.mail,
      this.spol,
      this.imeRoditelja
      );
  factory Mualim.fromJson(Map<String, dynamic> json) => _$MualimFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MualimToJson(this);
}