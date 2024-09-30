import 'package:json_annotation/json_annotation.dart';


part 'kamp_korisnik.g.dart';

@JsonSerializable()
class KampKorisnik{
   int? id;
   DateTime? datumDodavanja;
   int? korisnikId;
   int? kampId;

   KampKorisnik(
       this.id,
       this.datumDodavanja,
       this.korisnikId,
       );
   factory KampKorisnik.fromJson(Map<String, dynamic> json) => _$KampKorisnikFromJson(json);

   /// `toJson` is the convention for a class to declare support for serialization
   /// to JSON. The implementation simply calls the private, generated
   /// helper method `_$UserToJson`.
   Map<String, dynamic> toJson() => _$KampKorisnikToJson(this);
}