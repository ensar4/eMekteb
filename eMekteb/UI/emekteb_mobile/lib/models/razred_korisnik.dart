import 'package:charts_flutter/flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'razred_korisnik.g.dart';

@JsonSerializable()
class RazredKorisnik{
  int? id;
  int? korisnikId;
  int? razredId;
  DateTime datumUpisa;

  RazredKorisnik(
      this.id,
      this.korisnikId,
      this.razredId,
      this.datumUpisa,
      );

  factory RazredKorisnik.fromJson(Map<String, dynamic> json) => _$RazredKorisnikFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RazredKorisnikToJson(this);
}

