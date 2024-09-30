// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kamp_korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KampKorisnik _$KampKorisnikFromJson(Map<String, dynamic> json) => KampKorisnik(
      (json['id'] as num?)?.toInt(),
      json['datumDodavanja'] == null
          ? null
          : DateTime.parse(json['datumDodavanja'] as String),
      (json['korisnikId'] as num?)?.toInt(),
    )..kampId = (json['kampId'] as num?)?.toInt();

Map<String, dynamic> _$KampKorisnikToJson(KampKorisnik instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datumDodavanja': instance.datumDodavanja?.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'kampId': instance.kampId,
    };
