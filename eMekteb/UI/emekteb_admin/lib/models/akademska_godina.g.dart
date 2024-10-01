// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'akademska_godina.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AkademskaGodina _$AkademskaGodinaFromJson(Map<String, dynamic> json) =>
    AkademskaGodina(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['datumPocetka'] == null
          ? null
          : DateTime.parse(json['datumPocetka'] as String),
      json['datumZavrsetka'] == null
          ? null
          : DateTime.parse(json['datumZavrsetka'] as String),
      (json['ukupnoMekteba'] as num?)?.toInt(),
      (json['ukupnoUcenika'] as num?)?.toInt(),
      (json['prosjecnaOcjena'] as num?)?.toDouble(),
      (json['prosjecnoPrisustvo'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AkademskaGodinaToJson(AkademskaGodina instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'datumPocetka': instance.datumPocetka?.toIso8601String(),
      'datumZavrsetka': instance.datumZavrsetka?.toIso8601String(),
      'ukupnoMekteba': instance.ukupnoMekteba,
      'ukupnoUcenika': instance.ukupnoUcenika,
      'prosjecnaOcjena': instance.prosjecnaOcjena,
      'prosjecnoPrisustvo': instance.prosjecnoPrisustvo,
    };
