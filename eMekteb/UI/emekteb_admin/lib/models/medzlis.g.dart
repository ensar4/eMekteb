// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medzlis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medzlis _$MedzlisFromJson(Map<String, dynamic> json) => Medzlis(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['adresa'] as String?,
      json['telefon'] as String?,
      json['mail'] as String?,
      (json['ukupnoMekteba'] as num?)?.toInt(),
      (json['ukupnoUcenika'] as num?)?.toInt(),
      (json['prosjecnaOcjena'] as num?)?.toDouble(),
      (json['prosjecnoPrisustvo'] as num?)?.toDouble(),
      (json['muftijstvoId'] as num?)?.toInt(),
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
      'muftijstvoId': instance.muftijstvoId,
    };
