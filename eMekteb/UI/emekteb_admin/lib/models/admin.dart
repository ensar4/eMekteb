import 'package:json_annotation/json_annotation.dart';


part 'admin.g.dart';

@JsonSerializable()

class Admin{
  int? id;
  String? ime;
  String? prezime;
  String? username;
  String? telefon;
  String? status;
  String? mail;
  String? spol;
  DateTime? datumRodjenja;
  int? mektebId;

  Admin(
      this.id,
      this.ime,
      this.telefon,
      this.prezime,
      this.mektebId,
      this.status,
      this.datumRodjenja,
      this.username,
      this.mail,
      this.spol
      );
  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AdminToJson(this);
}