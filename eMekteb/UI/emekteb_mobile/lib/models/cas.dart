
import 'package:json_annotation/json_annotation.dart';

part 'cas.g.dart';

@JsonSerializable()
class Cas{
  int? id;
  DateTime datum;
  String razred;
  String lekcija;
  int mektebId;
  int? akademskaGodinaId;

  Cas(
      this.id,
      this.datum,
      this.razred,
      this.lekcija,
      this.mektebId,
      this.akademskaGodinaId
      );
  factory Cas.fromJson(Map<String, dynamic> json) => _$CasFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CasToJson(this);
}
