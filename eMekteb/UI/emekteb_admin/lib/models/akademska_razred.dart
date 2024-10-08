import 'package:json_annotation/json_annotation.dart';

part 'akademska_razred.g.dart';

@JsonSerializable()
class AkademskaRazred{
  int? id;
  int? akademskaGodinaId;
  int? razredId;


  AkademskaRazred(
      this.id,
      this.akademskaGodinaId,
      this.razredId,

      );

  factory AkademskaRazred.fromJson(Map<String, dynamic> json) => _$AkademskaRazredFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AkademskaRazredToJson(this);
}

