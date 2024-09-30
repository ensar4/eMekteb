import 'package:json_annotation/json_annotation.dart';

part 'akademska_mekteb.g.dart';

@JsonSerializable()
class AkademskaMekteb{
  int? id;
  int? akademskaGodinaId;
  int? mektebId;


  AkademskaMekteb(
      this.id,
      this.akademskaGodinaId,
      this.mektebId,

      );

  factory AkademskaMekteb.fromJson(Map<String, dynamic> json) => _$AkademskaMektebFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AkademskaMektebToJson(this);
}

