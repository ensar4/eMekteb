// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dodatna_lekcija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DodatnaLekcija _$DodatnaLekcijaFromJson(Map<String, dynamic> json) =>
    DodatnaLekcija(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String,
      json['tekst'] as String,
      (json['mektebId'] as num?)?.toInt(),
      (json['likes'] as num?)?.toInt(),
      (json['dislikes'] as num?)?.toInt(),
    )..datumObjavljivanja = json['datumObjavljivanja'] == null
        ? null
        : DateTime.parse(json['datumObjavljivanja'] as String);

Map<String, dynamic> _$DodatnaLekcijaToJson(DodatnaLekcija instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'tekst': instance.tekst,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'datumObjavljivanja': instance.datumObjavljivanja?.toIso8601String(),
      'mektebId': instance.mektebId,
    };
