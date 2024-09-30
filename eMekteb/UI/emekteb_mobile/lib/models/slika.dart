
import 'package:json_annotation/json_annotation.dart';

part 'slika.g.dart';

@JsonSerializable()
class Slika{
  int? id;
  String? slikaBytes;
  int? korisnikId;


  Slika(
      this.id,
      this.slikaBytes,
      this.korisnikId,
      );
  factory Slika.fromJson(Map<String, dynamic> json) => _$SlikaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SlikaToJson(this);
}
