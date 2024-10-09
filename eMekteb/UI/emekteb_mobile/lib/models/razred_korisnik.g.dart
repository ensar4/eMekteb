// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'razred_korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RazredKorisnik _$RazredKorisnikFromJson(Map<String, dynamic> json) =>
    RazredKorisnik(
      (json['id'] as num?)?.toInt(),
      (json['korisnikId'] as num?)?.toInt(),
      (json['razredId'] as num?)?.toInt(),
      DateTime.parse(json['datumUpisa'] as String),
    );

Map<String, dynamic> _$RazredKorisnikToJson(RazredKorisnik instance) =>
    <String, dynamic>{
      'id': instance.id,
      'korisnikId': instance.korisnikId,
      'razredId': instance.razredId,
      'datumUpisa': instance.datumUpisa.toIso8601String(),
    };
