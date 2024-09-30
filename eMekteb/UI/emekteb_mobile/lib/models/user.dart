import 'package:json_annotation/json_annotation.dart';


part 'user.g.dart';

@JsonSerializable()


class User{
   int? id;
   String ime;
   String prezime;
   String? username;
   String? telefon;
   String? mail;
   String? spol;
   String? status;
   DateTime? datumRodjenja;
   String? imeRoditelja;
   int? mektebId;
   int? razredId;
   String? nazivRazreda;
   double? prisustvo;
   double? prosjek;

  User(
      this.id,
      this.ime,
      this.telefon,
      this.prezime,
      this.mektebId,
      this.status,
      this.datumRodjenja,
      this.username,
      this.imeRoditelja,
      this.mail,
      this.spol,
      this.razredId,
      this.nazivRazreda,
      this.prosjek,
      this.prisustvo
      );
   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

   /// `toJson` is the convention for a class to declare support for serialization
   /// to JSON. The implementation simply calls the private, generated
   /// helper method `_$UserToJson`.
   Map<String, dynamic> toJson() => _$UserToJson(this);
}


