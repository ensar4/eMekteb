// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kamp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kamp _$KampFromJson(Map<String, dynamic> json) => Kamp(
      (json['id'] as num?)?.toInt(),
      json['naziv'] as String,
      json['opis'] as String?,
      DateTime.parse(json['datumPocetka'] as String),
      DateTime.parse(json['datumZavrsetka'] as String),
      json['voditelj'] as String?,
      (json['mektebId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KampToJson(Kamp instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'datumPocetka': instance.datumPocetka.toIso8601String(),
      'datumZavrsetka': instance.datumZavrsetka.toIso8601String(),
      'voditelj': instance.voditelj,
      'mektebId': instance.mektebId,
    };
