
import 'package:json_annotation/json_annotation.dart';

part 'takmicar.g.dart';

@JsonSerializable()
class Takmicar{
  int? id;
  String? ime;
  String? prezime;
  DateTime datumRodjenja;
  int? kategorijaId;
  int? ukupnoBodova;


  Takmicar(
      this.id,
      this.ime,
      this.prezime,
      this.datumRodjenja,
      this.kategorijaId,
      this.ukupnoBodova
      );
  factory Takmicar.fromJson(Map<String, dynamic> json) => _$TakmicarFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TakmicarToJson(this);
}
