// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mekteb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mekteb _$MektebFromJson(Map<String, dynamic> json) => Mekteb(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String?,
      json['telefon'] as String?,
      json['adresa'] as String?,
      json['mualim'] as String?,
      (json['medzlisId'] as num?)?.toInt(),
      (json['akademskaGodinaId'] as num?)?.toInt(),
      (json['ukupnoUcenika'] as num?)?.toInt(),
      (json['prosjecnoPrisustvo'] as num?)?.toDouble(),
      (json['prosjecnaOcjena'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MektebToJson(Mekteb instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'telefon': instance.telefon,
      'adresa': instance.adresa,
      'mualim': instance.mualim,
      'medzlisId': instance.medzlisId,
      'akademskaGodinaId': instance.akademskaGodinaId,
      'ukupnoUcenika': instance.ukupnoUcenika,
      'prosjecnoPrisustvo': instance.prosjecnoPrisustvo,
      'prosjecnaOcjena': instance.prosjecnaOcjena,
    };
