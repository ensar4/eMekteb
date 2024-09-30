
import 'package:json_annotation/json_annotation.dart';

part 'obavijest.g.dart';

@JsonSerializable()
class Obavijest{
  int? id;
  String naslov;
  String opis;
  DateTime datumObjave;
  String vrstaObjave;
  int mektebId;
  String stateMachine;

  Obavijest(
      this.id,
      this.naslov,
      this.opis,
      this.datumObjave,
      this.vrstaObjave,
      this.mektebId,
      this.stateMachine
      );
  factory Obavijest.fromJson(Map<String, dynamic> json) => _$ObavijestFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ObavijestToJson(this);
}
