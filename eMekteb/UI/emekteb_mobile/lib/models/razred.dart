
import 'package:json_annotation/json_annotation.dart';

part 'razred.g.dart';

@JsonSerializable()
class Razred{
  int id;
  String? naziv;



  Razred(
      this.id,
      this.naziv,
      );
  factory Razred.fromJson(Map<String, dynamic> json) => _$RazredFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RazredToJson(this);
}
