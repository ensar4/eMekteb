// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'takmicenje.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Takmicenje _$TakmicenjeFromJson(Map<String, dynamic> json) => Takmicenje(
      json['id'] as int?,
      json['godina'] as String?,
      json['datumOdrzavanja'] == null
          ? null
          : DateTime.parse(json['datumOdrzavanja'] as String),
      json['lokacija'] as String?,
      json['vrijemePocetka'] as String?,
      json['info'] as String?,
      json['medzlisId'] as int?,
      json['ukupnoUcenika'] as int?,
    );

Map<String, dynamic> _$TakmicenjeToJson(Takmicenje instance) =>
    <String, dynamic>{
      'id': instance.id,
      'godina': instance.godina,
      'datumOdrzavanja': instance.datumOdrzavanja?.toIso8601String(),
      'lokacija': instance.lokacija,
      'vrijemePocetka': instance.vrijemePocetka,
      'info': instance.info,
      'medzlisId': instance.medzlisId,
      'ukupnoUcenika': instance.ukupnoUcenika,
    };
