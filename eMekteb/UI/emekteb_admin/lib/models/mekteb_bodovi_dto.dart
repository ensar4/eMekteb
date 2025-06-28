import 'package:json_annotation/json_annotation.dart';

part 'mekteb_bodovi_dto.g.dart';

@JsonSerializable()
class MektebBodoviDto{
  int? mektebId;
  String? nazivMekteba;
  int? ukupnoBodova;

  MektebBodoviDto(
      this.mektebId,
      this.nazivMekteba,
      this.ukupnoBodova,
      );
  factory MektebBodoviDto.fromJson(Map<String, dynamic> json) => _$MektebBodoviDtoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MektebBodoviDtoToJson(this);
}
