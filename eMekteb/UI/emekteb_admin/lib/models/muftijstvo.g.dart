// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muftijstvo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Muftijstvo _$MuftijstvoFromJson(Map<String, dynamic> json) => Muftijstvo(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['adresa'] as String?,
      json['telefon'] as String?,
      json['mail'] as String?,
      (json['ukupnoMekteba'] as num?)?.toInt(),
      (json['ukupnoUcenika'] as num?)?.toInt(),
      (json['prosjecnaOcjena'] as num?)?.toDouble(),
      (json['prosjecnoPrisustvo'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MuftijstvoToJson(Muftijstvo instance) =>
    <String, dynamic>{
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
