// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medzlis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medzlis _$MedzlisFromJson(Map<String, dynamic> json) => Medzlis(
      json['id'] as int?,
      json['naziv'] as String?,
      json['adresa'] as String?,
      json['telefon'] as String?,
      json['mail'] as String?,
      json['ukupnoMekteba'] as int?,
      json['ukupnoUcenika'] as int?,
      (json['prosjecnaOcjena'] as num?)?.toDouble(),
      (json['prosjecnoPrisustvo'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MedzlisToJson(Medzlis instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'adresa': instance.adresa,
      'telefon': instance.telefon,
      'mail': instance.mail,
      'ukupnoMekteba': instance.ukupnoMekteba,
      'ukupnoUcenika': instance.ukupnoUcenika,
      'prosjecnaOcjena': instance.prosjecnaOcjena,
      'prosjecnoPrisustvo': instance.prosjecnoPrisustvo,
    };
