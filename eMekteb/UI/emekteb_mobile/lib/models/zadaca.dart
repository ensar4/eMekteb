
import 'package:json_annotation/json_annotation.dart';

part 'zadaca.g.dart';

@JsonSerializable()
class Zadaca{
  DateTime datumDodjele;
  int korisnikId;
  int ocjeneId;
  String lekcija;
  String? zaZadacu;
  int? razredId;
  String nazivRazreda;
  Zadaca(
      this.datumDodjele,
      this.korisnikId,
      this.ocjeneId,
      this.lekcija,
      this.razredId,
      this.nazivRazreda,
      this.zaZadacu
      );

  factory Zadaca.fromJson(Map<String, dynamic> json) => _$ZadacaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ZadacaToJson(this);
}
