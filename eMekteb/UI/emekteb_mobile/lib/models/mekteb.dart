import 'package:json_annotation/json_annotation.dart';


part 'mekteb.g.dart';

@JsonSerializable()
class Mekteb{
   int? id;
   String? naziv;
   String? telefon;
   String? adresa;
   String? mualim;
   int? medzlisId;
   int? akademskaGodinaId;
   int? ukupnoUcenika;
   double? prosjecnoPrisustvo;
   double? prosjecnaOcjena;

   Mekteb(this.id,
       this.naziv,
       this.telefon,
       this.adresa,
       this.mualim,
       this.medzlisId,
       this.akademskaGodinaId,
       this.ukupnoUcenika,
      this.prosjecnoPrisustvo,
      this.prosjecnaOcjena
       );
   factory Mekteb.fromJson(Map<String, dynamic> json) => _$MektebFromJson(json);

   /// `toJson` is the convention for a class to declare support for serialization
   /// to JSON. The implementation simply calls the private, generated
   /// helper method `_$UserToJson`.
   Map<String, dynamic> toJson() => _$MektebToJson(this);
}