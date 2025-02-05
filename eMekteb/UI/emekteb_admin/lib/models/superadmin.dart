import 'package:json_annotation/json_annotation.dart';


part 'superadmin.g.dart';

@JsonSerializable()

class SuperAdmin{
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
  int? medzlisId;
  int? muftijstvoId;

  SuperAdmin(
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
      this.imeRoditelja,
      this.medzlisId,
      this.muftijstvoId
      );
  factory SuperAdmin.fromJson(Map<String, dynamic> json) => _$SuperAdminFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SuperAdminToJson(this);
}