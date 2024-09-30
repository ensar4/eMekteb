import 'package:json_annotation/json_annotation.dart';

part 'ocjene.g.dart';

@JsonSerializable()
class Ocjene {
  int? id;
  String ocjena;

  Ocjene(
    this.id,
    this.ocjena,
  );

  factory Ocjene.fromJson(Map<String, dynamic> json) => _$OcjeneFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OcjeneToJson(this);
}
