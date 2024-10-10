
import 'package:json_annotation/json_annotation.dart';

part 'prisustvo.g.dart';

@JsonSerializable()
class Prisustvo{
  int? id;
  bool? prisutan;
  DateTime? datum;
  int? korisnikId;
  int? casId;
  int? razredId;
  String nazivRazreda;


  Prisustvo(
      this.id,
      this.prisutan,
      this.datum,
      this.casId,
      this.korisnikId,
      this.razredId,
      this.nazivRazreda
      );
  factory Prisustvo.fromJson(Map<String, dynamic> json) => _$PrisustvoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PrisustvoToJson(this);
}
